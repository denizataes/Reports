import SwiftUI

struct LoginHeaderView: View {
    let title: String
    let description: String
    let ip: String = Statics.baseURL
    
    var body: some View {
        
        VStack(alignment: .leading){
            HStack{Spacer()}
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .bold()
            
            Text(description)
                .font(.title)
            
//            if isIPHidden{
//                Text(ip)
//                    .foregroundStyle(.secondary)
//                    .font(.caption)
//            }
//                
            
        }
        .frame(height: 260)
        .padding(.leading)
        .background(Color(hex: "8A1538"))
        .foregroundColor(.white)
        .clipShape(RoundedShape(corners:[.bottomRight]))
    }
}

#Preview {
    LoginHeaderView(title: "Reports", description: "Welcome back")
}
