//
//  AboutProjectView.swift
//  TheBarber
//
//  Created by Jaloliddin Esonboyev on 29/10/2026.
//

import SwiftUI

struct AboutProjectView: View {
    
    var body: some View {
        List {
            Section {
                VStack(spacing: 16) {
                    Image("AppIcon1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    
                    VStack(spacing: 4) {
                        Text(AppInfo.appName)
                            .font(.title2)
                            .bold()
                        
                        Text(AppInfo.appVersionString)
                            .font(.body)
                        
                        Text(AppInfo.appTagline)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 8)
                            .padding(.bottom, 6)
                    }
                }
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
            }
            
            Section("Features") {
                ForEach(AppInfo.features) { feature in
                    
                    Label {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(feature.title)
                                .font(.headline)
                                .bold()
                            Text(feature.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    } icon: {
                        Image(systemName: feature.iconName)
                            .foregroundColor(.blue)
                    }
                }
            }
            
            Section("Project information") {
                HStack {
                    Label("Platform", systemImage: "apple.logo")
                        .foregroundStyle(.primary)
                    Spacer()
                    Text(AppInfo.platformName)
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                }
                
                HStack {
                    Label("Created by", systemImage: "person.crop.circle")
                        .foregroundStyle(.primary)
                    Spacer()
                    Text(AppInfo.developerName)
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                }
            }
            
            Section("Legal") {
                ForEach(AppInfo.legalDocuments) { doc in
                    NavigationLink {
                        LegalDocumentView(title: doc.title, content: doc.content)
                    } label: {
                        Label(doc.title, systemImage: doc.iconName)
                }
                }
            }
            
            Section {
                VStack(alignment: .center, spacing: 4) {
                    Text(AppInfo.copyright)
                        .multilineTextAlignment(.center)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct LegalDocumentView: View {
    let title: String
    let content: String
    
    var body: some View {
        ScrollView {
            Text(content)
                .font(.body)
                .foregroundColor(.secondary)
                .lineSpacing(6)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    NavigationStack {
        AboutProjectView()
    }
}
