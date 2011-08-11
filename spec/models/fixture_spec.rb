require_relative '../spec_helper'

describe Fixture do
  let :valid_params do
    { url: '/some/api', content: 'some content' }
  end

  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:content) }

  it "makes fixture active by default" do
    f = Fixture.create valid_params.except(:active)
    f.active.should be true
  end

  describe 'when created' do
    it "toggles active fixture for the same url" do
      f1 = Fixture.create valid_params.merge(active: true)
      f2 = Fixture.create valid_params.merge(active: true)

      f1.reload.active.should be false
    end
  end

  describe 'when saved' do
    it "toggles active fixture for the same url" do
      f1 = Fixture.create valid_params.merge(active: false)
      f2 = Fixture.create valid_params.merge(active: true)

      f1.active = true
      f1.save

      f2.reload.active.should be false
    end
  end
end
