







import SwiftUI

struct Test: View {
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {}) {
                    Text("24")
                }
                ForEach(0 ..< 5) { item in
                    NavigationLink(destination: Text("1")) { Text("link") }.padding()
                }
                Spacer()
            }
            .navigationTitle("test")
            .navigationBarItems(trailing: Text("123"))
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
