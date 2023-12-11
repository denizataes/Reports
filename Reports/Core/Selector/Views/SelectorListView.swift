//
//  DoctorListView.swift
//  Reports
//
//  Created by Deniz Ata Eş on 16.11.2023.
//

import SwiftUI

struct SelectorListView: View {
    @ObservedObject var viewModel: SelectorViewModel
    var selectorType: SelectorType
    @Environment(\.dismiss) private var dismiss
    @State private var selected: ResultModel? = nil
    var onSelection: (ResultModel) -> Void
    
    init(selectorType: SelectorType, onSelection: @escaping (ResultModel) -> Void) {
        self.viewModel = SelectorViewModel(selectorType: selectorType)
        self.selectorType = selectorType
        self.onSelection = onSelection
    }


    @State private var searchText = ""
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                
                Text(selectorType.title)
                    .font(.title)
                    
                
                Spacer()
                
                Button {
                    Haptics.shared.play(.soft)
                    dismiss()
                } label: {
                    Image(systemName: "multiply")
                        .foregroundColor(Color(hex: "009c80"))
                        .bold()
                        .shadow(radius: 1)
                }
                
            }
            .padding()
            
            ZStack(alignment: .trailing) {
                TextField("Search Unit...", text: $searchText)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
                    .padding(.horizontal)
                    .cornerRadius(10)
                    .textFieldStyle(PlainTextFieldStyle())
                    .bold()
                    .shadow(radius: 10)
                
                if !searchText.isEmpty {
                    Button(action: {
                        Haptics.shared.play(.soft)
                        searchText = ""
                    }) {
                        Image(systemName: "multiply")
                            .foregroundColor(.gray)
                            .padding(.horizontal, 16)
                            .padding(.trailing, 10)
                    }
                }
            }
            
            
            ScrollView{
                VStack{
                    ForEach(viewModel.selectorList.filter {
                        searchText.isEmpty  ? true : $0.name.localizedCaseInsensitiveContains(searchText)
                    }) { item in
                        SelectorView(selected: item, onSelection: { selected in
                            onSelection(selected)
                            dismiss()
                        }, selectedType: selectorType)
                        
                    }
                }
            }
        }
    }
}

//#Preview {
//    NavigationView{
//
//    }
//}
