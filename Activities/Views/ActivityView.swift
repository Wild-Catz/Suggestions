//
//  ActivityView.swift
//  Activities
//
//  Created by Roman Gorbenko on 22/02/23.
//

// swiftlint::disable line_length

import SwiftUI

struct DetailedActivity {
    let image: UIImage?
    let name: String
    let description: String
    var tips: [Tip]
    var need: String
    var isDone: Bool

    init(activity: Activity) {
        self.image = nil
        self.name = activity.name
        self.description = activity.description
        self.tips = activity.tips
        self.need = activity.need
        self.isDone = activity.isDone
    }
}

protocol ActivityViewModelProtocol: ObservableObject {
    var activity: DetailedActivity { get }
    func onButtonTapped()
    func onCloseButtonTapped()
}

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

// swiftlint::disable line_length

struct ActivityView<VM: ActivityViewModelProtocol>: View {
    let vm: VM

    var body: some View {
        ZStack {
            ActivityBigView(
                activityName: vm.activity.name,
                primaryColor: .purple,
                titleColor: .purple.opacity(0.4),
                whatYouNeedLabel: vm.activity.need,
                description: vm.activity.description,
                tipsAndTricls: vm.activity.tips
            )
            VStack {
                Spacer()
                WCButton(action: vm.onButtonTapped, text: "Done")
                    .disabled(vm.activity.isDone)
            }
            VStack {
                HStack {
                    Spacer()
                    Button(action: vm.onCloseButtonTapped) {
                        Text("Close")
                            .foregroundColor(.primary)
                            .font(.title2)
                    }
                }
                Spacer()
            }
        }
        .toolbar(.hidden)

    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(vm: ActivityViewModel(activity: FakeActivityService(personService: FakePersonService(), apiService: APIService(ratingService: RatingService())).getActivity(), onDone: {}, onClose: {}))
    }
}
