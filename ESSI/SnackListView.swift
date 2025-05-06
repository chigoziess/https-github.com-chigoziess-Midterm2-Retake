//
//  SnackListView.swift
//  ESSI
//
//  Created by Chigozie Sumani on 4/14/25.
//

import SwiftUI
import SwiftData

struct SnackListView: View {
    @Query private var snacks: [Snack]
    @State private var sheetIsPresented = false
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(snacks) {snack in
                    NavigationLink {
                        SnackDetailView(snack: snack)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(snack.name)
                                .font(.title)
                                .lineLimit(1)
                            HStack {
                                Text("Qty: \(snack.onHand)")
                                Text(snack.notes)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                                    .italic()
                            }
                            .font(.body)
                        }
                        
                    }
                    .swipeActions {
                        Button("Delete", role: .destructive) {
                            modelContext.delete(snack)
                            guard let _ = try? modelContext.save() else {
                                return
                            }
                            
                        }
                    }
                    
                }
            }
            .listStyle(.plain)
            .navigationTitle("Snacks on Hand:")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $sheetIsPresented) {
                NavigationStack  {
                    SnackDetailView(snack: Snack())
                }
            }
        }
        
    }
}

#Preview {
    SnackListView()
        .modelContainer(Snack.preview)
}
