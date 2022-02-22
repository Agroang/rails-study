RSpec.describe 'doubles' do
  it "tests the student's knowledge of the course's content" do
    db = double("Database Connection", connect: true, disconnect: "Goodbye" )
    expect(db.connect).to eq(true)
    expect(db.disconnect).to eq("Goodbye")

    fs = double("File System")
    allow(fs).to receive(:read).and_return("Romeo and Juliet")
    allow(fs).to receive(:write).and_return(false)
    expect(fs.read).to eq("Romeo and Juliet")
    expect(fs.write).to eq(false)
  end
end
