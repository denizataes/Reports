import SwiftUI
///Uses for the loading screen
struct CustomLoadingView: View {
    @State private var rotationAngle = 0.0
    var imageName: String = "stethoscope"
    var imageColor: String = "8A1538"

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .opacity(0.8)
                .ignoresSafeArea()

            VStack {
                HStack{
                    Image(systemName: imageName)
                        .font(.system(size: 30))
                        .rotationEffect(Angle(degrees: rotationAngle))
                        .foregroundColor(Color(hex: imageColor))
                        .animation(Animation.linear(duration: 0.9).repeatForever(autoreverses: false))
                }
            }
        }
        .onAppear {
            withAnimation {
                rotationAngle = 360
            }
        }
    }
}
