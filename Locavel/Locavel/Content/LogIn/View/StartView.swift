import SwiftUI

struct StartView: View {
    
    @State private var isLaunching: Bool = true
    @State private var showLandingPage0: Bool = false
    @State private var showLandingPage1: Bool = false
    @State private var showLandingPage2: Bool = false
    
    var body: some View {
        if isLaunching {
            SplashView()
                .opacity(isLaunching ? 1 : 0)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.easeIn(duration: 1.5)) {
                            isLaunching = false
                            showLandingPage0 = true
                        }
                    }
                }
        } else if showLandingPage0 {
            LandingPageView0()
                .transition(.opacity)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation(.easeIn(duration: 1)) {
                            showLandingPage0 = false
                            showLandingPage1 = true
                        }
                    }
                }
        } else if showLandingPage1 {
            LandingPageView1()
                .transition(.opacity)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeIn(duration: 1)) {
                            showLandingPage1 = false
                            showLandingPage2 = true
                        }
                    }
                }
        } else if showLandingPage2 {
            LandingPageView2()
                .transition(.opacity)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation(.easeIn(duration: 1)) {
                            showLandingPage2 = false
                        }
                    }
                }
        } else {
            LogInView()
        }
    }
}

struct LandingPageView0: View {
    var body: some View {
        VStack {
            Spacer()
            VStack (spacing:0){
                Text("특별한 여행을")
                    .font(.title)
                    .bold()
                Text("시작해보세요")
                    .font(.title)
                    .bold()
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LandingPageView1: View {
    var body: some View {
        VStack {
            Spacer()
            Image("Logo")
                .resizable()
                .frame(width: 183, height: 37)
                .padding(.bottom,50)
            VStack (spacing:0){
                Text("당신의 여행에")
                    .font(.title)
                    .bold()
                Text("색깔을 더합니다")
                    .font(.title)
                    .bold()
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LandingPageView2: View {
    var body: some View {
        VStack {
            Spacer()
            Image("Logo")
                .resizable()
                .frame(width: 183, height: 37)
                .padding(.bottom,50)
            VStack (spacing:0){
                Text("당신의 여행에")
                    .font(.title)
                    .bold()
                    .foregroundColor(ColorManager.AccentColor)
                Text("색깔을 더합니다")
                    .font(.title)
                    .bold()
                    .foregroundColor(ColorManager.AccentColor)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    StartView()
}
