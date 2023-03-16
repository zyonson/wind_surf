require 'rails_helper'

RSpec.describe Store, type: :model do
  it { is_expected.to validate_content_type_of(:image).allowing('jpg') }
  it { is_expected.to validate_content_type_of(:image).rejecting('xml') }
  it { is_expected.to validate_size_of(:image).less_than_or_equal_to(10.megabytes) }
end
