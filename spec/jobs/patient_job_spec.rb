require 'rails_helper'

# https://github.com/gocardless/rspec-activejob
# RSpec.describe PatientJob, type: :job do
#   describe "called in asumistream" do
#     before(:each) do
#       @patient = create(:patient)
#       @params = attributes_for(:asumi_tweet)
#     end
#     it "should create new asumi tweet" do
#       make_request = PatientJob.perform_later(@patient.twitter_id, @params[:tweet], @params[:tweet_id], @params[:tweet_time])
#       expect(make_request).to enqueue_a(PatientJob).with(global_id(@patient))
#     end
#   end
# end
