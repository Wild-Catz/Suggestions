//
//  OnboardingEndView.swift
//  Activities
//
//  Created by Valentina Russo on 02/03/23.
//

import SwiftUI

protocol OnboardingEndViewModelProtocol: ObservableObject {
    var onOnboardingDone: () -> Void { get }
    func onButtonTapped()
}

final class OnboardingEndViewModel: OnboardingEndViewModelProtocol {
    let onOnboardingDone: () -> Void
    
    init(onOnboardingDone: @escaping () -> Void) {
        self.onOnboardingDone = onOnboardingDone
    }
    
    func onButtonTapped() {
        onOnboardingDone()
    }
}

struct OnboardingEndView<VM: OnboardingEndViewModel>: View {
    let vm: VM
    
    var body: some View {
        VStack {
            Text("onboarding_end_title")
                .font(.largeTitle)
                .bold()
                .padding(.top)
            Spacer()
            Image("Onboarding_rocket")
                .resizable()
                .scaledToFit()
                .frame(height: 230)
            Spacer()
            Text("onboarding_end_subtitle")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Spacer()
            WCButton(action: vm.onButtonTapped, text: "Let's do it!", color: .black, colorFor: .white)
        }
        .padding()
        .toolbar(.hidden)
    }
}

struct OnboardingEndView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingEndView(vm: OnboardingEndViewModel(onOnboardingDone: { }))
    }
}
