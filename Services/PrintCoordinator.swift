//
//  PrintCoordinator.swift
//  LexWriter
//
//  Created by Terje Moe on 29/08/2026.
//

#if canImport(UIKit)
import UIKit

enum PrintCoordinator {
    static func markup(
        for option: DocumentOutputOption,
        makeDocument: (AppLanguage) -> String
    ) -> String {
        let documents = option.languages.map(makeDocument)
        guard let firstDocument = documents.first else {
            return ""
        }

        return documents.dropFirst().reduce(firstDocument) { combinedDocument, document in
            appendAsNewPage(document, to: combinedDocument)
        }
    }

    private static func appendAsNewPage(_ document: String, to existingDocument: String) -> String {
        guard
            let closingBodyRange = existingDocument.range(of: "</body>", options: .caseInsensitive),
            let openingBodyRange = document.range(of: "<body>", options: .caseInsensitive),
            let documentClosingBodyRange = document.range(
                of: "</body>",
                options: [.caseInsensitive, .backwards]
            )
        else {
            return existingDocument + document
        }

        let bodyContent = document[openingBodyRange.upperBound..<documentClosingBodyRange.lowerBound]
        let newPage = """
        <div style="break-before: page; page-break-before: always;"></div>
        \(bodyContent)
        """

        var result = existingDocument
        result.insert(contentsOf: newPage, at: closingBodyRange.lowerBound)
        return result
    }

    @MainActor
    static func present(markupText: String, jobName: String) {
        let controller = UIPrintInteractionController.shared
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.jobName = jobName
        printInfo.outputType = .general
        controller.printInfo = printInfo
        controller.printFormatter = UIMarkupTextPrintFormatter(markupText: markupText)
        controller.present(animated: true)
    }

    @MainActor
    @discardableResult
    static func exportPDF(markupText: String, jobName: String) -> Bool {
        guard let fileURL = try? makeTemporaryPDF(markupText: markupText, jobName: jobName) else {
            return false
        }
        guard let presenter = topViewController() else { return false }
        let controller = UIDocumentPickerViewController(forExporting: [fileURL], asCopy: true)
        presenter.present(controller, animated: true)
        return true
    }

    private static func makeTemporaryPDF(markupText: String, jobName: String) throws -> URL {
        let renderer = UIPrintPageRenderer()
        renderer.addPrintFormatter(UIMarkupTextPrintFormatter(markupText: markupText), startingAtPageAt: 0)

        let pageRect = CGRect(x: 0, y: 0, width: 595.2, height: 841.8)
        let printableRect = pageRect.insetBy(dx: 36, dy: 36)
        renderer.setValue(pageRect, forKey: "paperRect")
        renderer.setValue(printableRect, forKey: "printableRect")

        let pdfRenderer = UIGraphicsPDFRenderer(bounds: pageRect)
        let data = pdfRenderer.pdfData { context in
            for pageIndex in 0 ..< renderer.numberOfPages {
                context.beginPage()
                renderer.drawPage(at: pageIndex, in: context.pdfContextBounds)
            }
        }

        let fileURL = FileManager.default.temporaryDirectory
            .appendingPathComponent(sanitizedFileName(for: jobName))
            .appendingPathExtension("pdf")
        try data.write(to: fileURL, options: .atomic)
        return fileURL
    }

    static func sanitizedFileName(for jobName: String) -> String {
        let invalidCharacters = CharacterSet.alphanumerics.inverted
        let components = jobName.components(separatedBy: invalidCharacters).filter { $0.isEmpty == false }
        return components.isEmpty ? "Document" : components.joined(separator: "-")
    }

    @MainActor
    private static func topViewController(
        from viewController: UIViewController? = nil
    ) -> UIViewController? {
        let resolvedViewController: UIViewController? = if let viewController {
            viewController
        } else {
            UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .first(where: { $0.activationState == .foregroundActive })?
                .windows
                .first(where: \.isKeyWindow)?
                .rootViewController
        }

        if let navigationController = resolvedViewController as? UINavigationController {
            return topViewController(from: navigationController.visibleViewController)
        }

        if let tabBarController = resolvedViewController as? UITabBarController {
            return topViewController(from: tabBarController.selectedViewController)
        }

        if let presentedViewController = resolvedViewController?.presentedViewController {
            return topViewController(from: presentedViewController)
        }

        return resolvedViewController
    }
}
#endif
