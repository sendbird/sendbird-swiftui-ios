//
//  SendbirdUIProvider.swift
//  SendbirdUIKit
//
//  Created by Celine Moon on 10/21/24.
//

import Foundation
import UIKit
import SwiftUI

protocol SendbirdUIProvider: ObservableObject {
    associatedtype ViewController: UIViewController
    associatedtype EventHandlers
    var eventHandlers: EventHandlers { get set }
    var viewController: ViewController? { get set }
    
    /// Binds the provider with its corresponding view controller & view model.
    func bind(viewController: ViewController)
}
