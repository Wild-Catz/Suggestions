//
//  ActivityView.swift
//  Activities
//
//  Created by Roman Gorbenko on 22/02/23.
//

// swiftlint::disable line_length

import SwiftUI

// MARK: - DetailedActivity

struct DetailedActivity {
    let image: UIImage?
    let name: String
    let description: String
    let tips: [Tip]
    let need: String
    let isDone: Bool
    let category: Category
    
    init(activity: Activity) {
        self.image = nil
        self.name = activity.name
        self.description = activity.description
        self.tips = activity.tips
        self.need = activity.need
        self.isDone = activity.isDone
        self.category = activity.category
    }
}

// MARK: - ActivityViewModel Protocol

protocol ActivityViewModelProtocol: ObservableObject {
    var activity: DetailedActivity { get }
    func onButtonTapped()
    func onCloseButtonTapped()
}

// MARK: - ActivityViewModel

final class ActivityViewModel: ActivityViewModelProtocol {
    @Published var activity: DetailedActivity
    
    private let onDone: () -> Void
    private let onClose: () -> Void
    
    init(activity: Activity, onDone: @escaping () -> Void, onClose: @escaping () -> Void) {
        self.activity = DetailedActivity(activity: activity)
        self.onDone = onDone
        self.onClose = onClose
    }
    
    func onButtonTapped() {
        onDone()
    }
    
    func onCloseButtonTapped() {
        onClose()
    }
}

// MARK: - ActivityView

struct ActivityView<VM: ActivityViewModelProtocol>: View {
    let vm: VM
    
    var body: some View {
        ZStack {
            ActivityBigView(
                activityName: vm.activity.name,
                primaryColor: Color(vm.activity.category.rawValue),
                titleColor: Color(vm.activity.category.rawValue).opacity(0.5),
                whatYouNeedLabel: vm.activity.need,
                description: vm.activity.description,
                tipsAndTricls: vm.activity.tips
            )
            VStack {
                Spacer()
                WCButton(action: vm.onButtonTapped, text: "done", color: Color(vm.activity.category.rawValue), colorFor: .black)
                    .disabled(vm.activity.isDone)
                    .buttonStyle(.plain)
            }
            VStack {
                HStack {
                    Spacer()
                    Button(action: vm.onCloseButtonTapped) {
                        Image(systemName: "x.circle.fill")
                            .padding(.top, 20)
                            .foregroundColor(.primary)
                            .font(.system(size: 30))
                    }
                    .padding(.horizontal)
                }
                Spacer()
            }
        }
        .toolbar(.hidden)
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(vm: ActivityViewModel(
            activity: Self.activityService.getActivity(),
            onDone: {},
            onClose: {})
        )
    }
}
