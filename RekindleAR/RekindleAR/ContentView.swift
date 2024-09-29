//
//  ContentView.swift
//  RekindleAR
//
//  Created by Savvy Dusad on 9/29/24.
//

import SwiftUI
import PhotosUI
import UniformTypeIdentifiers


// MARK: - ContentView (Login)

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var isLoggedin = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.purple.ignoresSafeArea()
                Circle().scale(1.7).foregroundColor(.white.opacity(0.15))
                Circle().scale(1.35).foregroundColor(.white)
                
                VStack {
                    Text("Login")
                        .font(.title).bold().padding()
                    
                    TextField("Username", text: $username)
                        .padding().frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                    
                    SecureField("Password", text: $password)
                        .padding().frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                    
                    Button("Login") {
                        AuthenticateUser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.purple)
                    .cornerRadius(10)
                    
                    if isLoggedin {
                        NavigationLink(destination: DashView(username: username), isActive: $isLoggedin) {
                            EmptyView()
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    func AuthenticateUser(username: String, password: String) {
        if username.lowercased() == "savs123" && password.lowercased() == "abc123" {
            wrongUsername = 0
            wrongPassword = 0
            isLoggedin = true
        } else {
            wrongUsername = username.lowercased() == "savs123" ? 0 : 2
            wrongPassword = password.lowercased() == "abc123" ? 0 : 2
        }
    }
}

// MARK: - DashView (Main Dashboard)

struct DashView: View {
    var username: String
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                VStack {
                    Image("logo_photo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(Rectangle())
                        .padding(.top, 20)
                    
                    Text("Welcome, Arya!")
                        .font(.largeTitle).bold()
                        .padding(.top, 20)
                    
                    VStack(spacing: 20) {
                        NavigationLink(destination: InfoView()) {
                            DashButtonView(buttonText: "How to Use This Tool", buttonColor: .purple)
                        }
                        NavigationLink(destination: EditProfileView()) {
                            DashButtonView(buttonText: "Edit Profile", buttonColor: .purple)
                        }
                        NavigationLink(destination: CreateProfileView()) {
                            DashButtonView(buttonText: "Create Family Profiles", buttonColor: .purple)
                        }
                        NavigationLink(destination: TrackCareView()) {
                            DashButtonView(buttonText: "Track Sonya's Progress", buttonColor: .purple)
                        }
                        NavigationLink(destination: UploadPhotosView()) {
                            DashButtonView(buttonText: "Upload Memories", buttonColor: .purple)
                        }
                    }
                    .padding(.top, 40)
                }
                Image("sonya_photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding([.top, .trailing], 0)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
                            
            
// MARK: - Reusable Button View

struct DashButtonView: View {
    var buttonText: String
    var buttonColor: Color
    
    var body: some View {
        Text(buttonText)
            .foregroundColor(.white)
            .frame(width: 250, height: 50)
            .background(buttonColor)
            .cornerRadius(10)
    }
}

// MARK: - InfoView (Static Information Page)

struct InfoView: View {
    var body: some View {
        ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Group {
                            Text("About")
                                .font(.title).bold()
                            
                            Text("RevivalAR offers a personalized augmented reality experience that overlays digital information on family photos. By using visual cues to trigger memory recall, the app helps Alzheimer's patients better recognize their environment, aiding cognitive rehabilitation.")
                                .font(.body)
                        }
                        .padding(.bottom)
                        
                        Group {
                            Text("How to Use:")
                                .font(.title).bold()
                            
                            FeatureDescription(
                                title: "1. Edit Profile",
                                description: "Allows the user to customize patient details to inform caregivers and enhance the personalized experience."
                            )
                            
                            FeatureDescription(
                                title: "2. Create Family Profiles",
                                description: "Allows the user to add multiple family members, enabling personalized memories and interactions for each patient."
                            )
                            
                            FeatureDescription(
                                title: "3. Track Patient Progress",
                                description: "Allows the user to monitor cognitive improvements, memory retention, and engagement levels over time."
                            )
                            
                            FeatureDescription(
                                title: "4. Upload Memories",
                                description: "Allows the user to upload photos, videos, and descriptions to create memory associations for AR-based recall."
                            )
                        }
                    }
                    .padding()
                }
                .navigationTitle("How to Use This Tool")
            }
        }

        struct FeatureDescription: View {
            let title: String
            let description: String
            
            var body: some View {
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.body).bold()
                    Text(description)
                        .font(.body)
                }
                .padding(.bottom, 10)
            }
        }

        struct InfoView_Previews: PreviewProvider {
            static var previews: some View {
                NavigationView {
                    InfoView()
                }
            }
        }

// MARK: - EditProfileView

struct EditProfileView: View {
    @State private var name: String = "Sonya Singh"
    @State private var age: String = "78"
    @State private var birthdate: Date = {
        var dateComponents = DateComponents()
        dateComponents.year = 1946
        dateComponents.month = 5
        dateComponents.day = 18
        return Calendar.current.date(from: dateComponents) ?? Date()
    }()
    @State private var medicalConditions: String = "Alzheimer's, Hypertension"
    @State private var emergencyContact: String = "Abhijay Salvi (Son) - 431-967-3092"
    
    var body: some View {
        Form {
            Section(header: Text("Patient Information")) {
                TextField("Name", text: $name)
                TextField("Age", text: $age)
                    .keyboardType(.numberPad)
                DatePicker("Birthdate", selection: $birthdate, displayedComponents: .date)
            }
            
            Section(header: Text("Medical Information")) {
                TextField("Medical Conditions", text: $medicalConditions)
            }
            
            Section(header: Text("Emergency Contact")) {
                TextField("Emergency Contact", text: $emergencyContact)
            }
            
            Section {
                Button(action: saveProfile) {
                    Text("Save Changes")
                }
            }
        }
        .navigationTitle("Edit Profile")
    }
    
    func saveProfile() {
        // Here you would typically save the profile information
        // For now, we'll just print the information
        print("Profile saved:")
        print("Name: \(name)")
        print("Age: \(age)")
        print("Birthdate: \(birthdate)")
        print("Medical Conditions: \(medicalConditions)")
        print("Emergency Contact: \(emergencyContact)")
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditProfileView()
        }
        .navigationBarTitle("Edit Profile")
    }
}

// MARK: - Profile Struct

struct Profile: Identifiable {
    var id = UUID()
    var name: String
    var relationship: String
    var age: Int
    var image: String
}

// MARK: - CreateProfileView (Family Profiles)

struct CreateProfileView: View {
    @State private var profiles = [
        Profile(name: "Savvy Dusad", relationship: "Granddaughter", age: 18, image: "savvy_photo"),
        Profile(name: "Aditya Jain", relationship: "Grandson", age: 17, image: "aditya_photo"),
        Profile(name: "Megha Goddu", relationship: "Daughter", age: 47, image: "megha_photo"),
        Profile(name: "Abhijay Salvi", relationship: "Son", age: 50, image: "abhijay_photo")
    ]
    
    var body: some View {
        VStack {
            Text("Profiles")
                .font(.largeTitle).bold().padding(.top)
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(profiles) { profile in
                        NavigationLink(destination: ProfileDetailView(profile: profile)) {
                            HStack {
                                Image(profile.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .padding()
                                
                                Text(profile.name)
                                    .font(.headline)
                                
                                Spacer()
                            }
                            .frame(width: 300, height: 60)
                            .background(Color.purple.opacity(0.2))
                            .cornerRadius(10)
                        }
                    }
                    
                    Button(action: {
                        createNewProfile()
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.purple)
                            Text("Create New Profile")
                                .font(.headline)
                        }
                        .frame(width: 300, height: 60)
                        .background(Color.purple.opacity(0.2))
                        .cornerRadius(10)
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Family Profiles")
        }
    }
    
    func createNewProfile() {
        profiles.append(Profile(name: "New Profile", relationship: "Unknown", age: 0, image: "person.fill"))
    }
}

// MARK: - Profile Detail View

struct ProfileDetailView: View {
    var profile: Profile
    @State private var showingFilePicker = false
    @State private var uploadedFileURL: URL?
    
    var body: some View {
        VStack {
            Image(profile.image)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .padding(.top, 40)
            
            Text(profile.name)
                .font(.largeTitle)
                .bold()
                .padding(.top, 20)
            
            Text("Relationship: \(profile.relationship)")
                .font(.headline)
                .padding(.top, 10)
            
            Text("Age: \(profile.age)")
                .font(.headline)
                .padding(.top, 10)
            
            Button("Upload Music File") {
                showingFilePicker.toggle()
            }
            .foregroundColor(.white)
            .frame(width: 250, height: 50)
            .background(Color.purple)
            .cornerRadius(10)
            .padding(.top, 20)
            
            if let fileURL = uploadedFileURL {
                Text("Uploaded: \(fileURL.lastPathComponent)")
                    .font(.subheadline)
                    .padding(.top, 20)
            }
            Spacer()
        }
        .fileImporter(isPresented: $showingFilePicker, allowedContentTypes: [.audio], onCompletion: { result in
            switch result {
            case .success(let url):
                uploadedFileURL = url
            case .failure(let error):
                print("Failed to upload file: \(error.localizedDescription)")
            }
        })
        .navigationTitle("Profile Details")
    }
}

// MARK: - TrackCareView
struct TrackCareView: View {
    @State private var currentDate = Date()
    
    var body: some View {
        HStack {
            Image("logo_photo")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(width: 175, height: 125)
                .clipShape(Rectangle())
                .padding([.top, .trailing], 0.2)
        }
        VStack {
            Text("Track Sonya's Progress")
                .font(.largeTitle)
                .bold()
                .padding()
            
            CalendarView(currentDate: $currentDate)
        }
        .navigationTitle("Track Progress")
    }
}

struct CalendarView: View {
    @Binding var currentDate: Date
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    var body: some View {
        VStack {
            Text(monthYearString)
                .font(.title2)
                .padding()
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(days, id: \.self) { date in
                    if let date = date {
                        NavigationLink(destination: InteractionSummaryView(date: date)) {
                            DayView(date: date)
                        }
                    } else {
                        Text("")
                    }
                }
            }
        }
    }
    
    private var monthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentDate)
    }
    
    private var days: [Date?] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: currentDate) else { return [] }
        let monthFirstWeekday = calendar.component(.weekday, from: monthInterval.start)
        let monthLength = calendar.component(.day, from: monthInterval.end.addingTimeInterval(-1))
        
        let emptyDays = (1..<monthFirstWeekday).map { _ in nil as Date? }
        let monthDays = (1...monthLength).map { day -> Date in
            calendar.date(from: DateComponents(year: calendar.component(.year, from: currentDate),
                                               month: calendar.component(.month, from: currentDate),
                                               day: day))!
        }
        return emptyDays + monthDays
    }
}

struct DayView: View {
    let date: Date
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    var body: some View {
        VStack {
            Text(dateFormatter.string(from: date))
                .font(.subheadline)
            
            if calendar.isDate(date, inSameDayAs: Date(timeIntervalSince1970: 1727568000)) { // Sept 28, 2024
                HStack {
                    Image("savvy_photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                    Image("abhijay_photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                }
            } else if calendar.isDate(date, inSameDayAs: Date(timeIntervalSince1970: 1727654400)) { // Sept 29, 2024
                HStack {
                    Image("megha_photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                    Image("aditya_photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .clipShape(Circle())
                }
            }
        }
        .frame(width: 55, height: 60)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}

struct InteractionSummaryView: View {
    let date: Date
    @State private var mostInteracted: [Profile] = []
    @State private var leastInteracted: [Profile] = []
    
    var body: some View {
        VStack {
            Text("Interaction Summary")
                .font(.title)
                .padding()
            
            Text(formattedDate)
                .font(.subheadline)
                .padding(.bottom)
            
            Text("Most Interacted")
                .font(.headline)
            ForEach(mostInteracted) { profile in
                ProfileRow(profile: profile)
            }
            
            Divider().padding()
            
            Text("Least Interacted")
                .font(.headline)
            ForEach(leastInteracted) { profile in
                ProfileRow(profile: profile)
            }
        }
        .onAppear {
            loadInteractionData()
        }
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: date)
    }
    
    private func loadInteractionData() {
        // This is where you would normally fetch data from a database or API
        // For this example, we'll use hardcoded data
        let calendar = Calendar.current
        if calendar.isDate(date, inSameDayAs: Date(timeIntervalSince1970: 1727568000)) { // Sept 28, 2024
            mostInteracted = [
                Profile(name: "Savvy Dusad", relationship: "Granddaughter", age: 18, image: "savvy_photo"),
                Profile(name: "Abhijay Salvi", relationship: "Son", age: 50, image: "abhijay_photo")
            ]
            leastInteracted = [
                Profile(name: "Megha Goddu", relationship: "Daughter", age: 47, image: "megha_photo"),
                Profile(name: "Aditya Jain", relationship: "Grandson", age: 17, image: "aditya_photo")
            ]
        } else if calendar.isDate(date, inSameDayAs: Date(timeIntervalSince1970: 1727654400)) { // Sept 29, 2024
            mostInteracted = [
                Profile(name: "Megha Goddu", relationship: "Daughter", age: 47, image: "megha_photo"),
                Profile(name: "Aditya Jain", relationship: "Grandson", age: 17, image: "aditya_photo")
            ]
            leastInteracted = [
                Profile(name: "Savvy Dusad", relationship: "Granddaughter", age: 18, image: "savvy_photo"),
                Profile(name: "Abhijay Salvi", relationship: "Son", age: 50, image: "abhijay_photo")
            ]
        }
    }
}

struct ProfileRow: View {
    let profile: Profile
    
    var body: some View {
        HStack {
            Image(profile.image)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(profile.name)
                    .font(.headline)
                Text(profile.relationship)
                    .font(.subheadline)
            }
        }
        .padding(.vertical, 5)
    }
}


// MARK: - UploadPhotosView (Multiple Photo Upload)

struct UploadPhotosView: View {
    @State private var isPickerPresented = false
    @State private var selectedImages: [UIImage] = []
    @State private var isUploaded = false
    
    var body: some View {
        VStack {
            Text("Upload Media")
                .font(.largeTitle)
                .bold()
                .padding(.top, 20)
            
            Button("Select Photos") {
                isPickerPresented = true
            }
            .foregroundColor(.white)
            .frame(width: 250, height: 50)
            .background(Color.purple)
            .cornerRadius(10)
            .padding(.top, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(selectedImages, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                    }
                }
            }
            .frame(height: 120)
            .padding(.top, 20)
            
            if !selectedImages.isEmpty {
                Button("Upload") {
                    isUploaded = true
                }
                .foregroundColor(.white)
                .frame(width: 250, height: 50)
                .background(Color.purple)
                .cornerRadius(10)
                .padding(.top, 20)
            }
            
            if isUploaded {
                Text("Your memory is uploaded!")
                    .font(.headline)
                    .foregroundColor(.purple)
                    .padding(.top, 20)
            } else {
                Text("No media uploaded yet")
                    .foregroundColor(.gray)
                    .padding(.top, 20)
            }
            
            Spacer()
        }
        .navigationTitle("Upload Memories")
        .sheet(isPresented: $isPickerPresented) {
            PhotoPicker(selectedImages: $selectedImages)
        }
    }
}

// MARK: - PhotoPicker (Image Picker)

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage]
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 0
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                        if let image = image as? UIImage {
                            DispatchQueue.main.async {
                                self.parent.selectedImages.append(image)
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - PreviewProvider

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


