//
//  OnboardingView.swift
//  GetRec
//
//  Created by Berke Can Kandemir on 5/1/22.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - PROPERTY
    @AppStorage("screen") var screen: Int = 1
    @AppStorage("return") var isReturn: Bool = false
    let hapticImpact = UIImpactFeedbackGenerator(style: .light)
    
    // MARK: - BODY
    var body: some View {
        GeometryReader { metrics in
            VStack(spacing: 20) {
                Spacer()
                Text("Welcome to \nGetRec")
                    .font(.largeTitle.weight(.bold))
                    .multilineTextAlignment(.center)
                Spacer()
                Image("GetRec-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 0, maxWidth: 311, minHeight: 0, maxHeight: 311, alignment: .center)
                    .clipShape(Circle())
                Spacer()
                Spacer()
                Button(action: {
                    withAnimation {
                        hapticImpact.impactOccurred()
                        isReturn = false
                        screen = 2
                    }
                }) {
                    HStack {
                        Text("Start")
                            .font(.title2.weight(.bold))
                    } //: HSTACK
                    .frame(width: metrics.size.width * 0.9, height: 50, alignment: .center)
                } //: BUTTON
                .foregroundColor(.white)
                .contentShape(Rectangle())
                .background(Color("ColorPurple"))
                .cornerRadius(8)
                .padding(.bottom, 40)
            } //: VSTACK
            .padding(.horizontal, 20)
        }
    }
}

// MARK: - PREVIEW
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            
    }
}
