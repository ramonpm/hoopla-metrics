require 'rails_helper'

RSpec.feature 'Metric Values', type: :feature do
  let(:metric_value) { create(:metric_value) }

  it 'shows a list of values' do
    metric = metric_value.metric
    visit hoopla_metric_metric_values_path(metric)
    expect(page).to have_content("List of Values for #{metric.name}")
    expect(page).to have_content("#{metric_value.user.name} #{metric_value.value}")
  end

  it 'shows 0 to user without a value' do
    user = create(:user, first_name: 'No', last_name: 'Value')
    visit hoopla_metric_metric_values_path(metric_value.metric)
    expect(page).to have_content("No Value 0.0")
  end

  it 'has a link to create a metric value if no value for the user' do
    user = create(:user, first_name: 'No', last_name: 'Value')
    metric = metric_value.metric
    visit hoopla_metric_metric_values_path(metric)
    click_on "No Value"
    expect(page).to have_current_path(new_hoopla_metric_metric_value_path(metric, user_id: user.id))
  end

  it 'has a link to edit a metric value if it exists for the user' do
    metric = metric_value.metric
    visit hoopla_metric_metric_values_path(metric)
    click_on metric_value.user.name
    expect(current_path).to eq(edit_hoopla_metric_metric_value_path(metric, metric_value))
  end

  context 'creating a new metric value' do
    let(:user) { create(:user) }

    before(:each) do
      visit new_hoopla_metric_metric_value_path(metric_value.metric, user_id: user.id)
    end

    it 'sets user and metric to the ones in the url' do
      metric = metric_value.metric
      expect(page).to have_content("#{metric.name} value for #{user.name}")
      expect(find('#hoopla_metric_value_user_id', visible: false).value.to_i).to eq(user.id)
      expect(find('#hoopla_metric_value_metric_id', visible: false).value.to_i).to eq(metric.id)
    end
  end
end
