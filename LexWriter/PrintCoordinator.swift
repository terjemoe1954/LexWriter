//
//  PrintCoordinator.swift
//  LexWriter
//
//  Created by Terje Moe on 29/08/2026.
//

#if canImport(UIKit)
import UIKit

enum PrintCoordinator {
    static func present(markupText: String, jobName: String) {
        let controller = UIPrintInteractionController.shared
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.jobName = jobName
        printInfo.outputType = .general
        controller.printInfo = printInfo
        controller.printFormatter = UIMarkupTextPrintFormatter(markupText: markupText)
        controller.present(animated: true)
    }
}
#endif
