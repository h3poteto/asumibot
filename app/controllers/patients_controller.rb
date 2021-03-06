# frozen_string_literal: true

class PatientsController < ApplicationController
  layout "user"

  # GET /patients
  # GET /patients.json
  def index
    @patients = Patient.includes(:asumi_tweets).rankings.take(10)
    @month_ranking = MonthRanking.includes(:patient).level_order.limit(20)
    @prev_rank = Patient.avail_prev_rankings
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
    @patient = Patient.
      includes(:asumi_tweets).
      where(id: params[:id]).
      order("asumi_tweets.tweet_time DESC").first

    redirect_to action: :index and return if @patient.protect

    @all_patients = Patient.rankings

    # for js graph
    @today = Date.current
    @datedata = Date.current.weeks_ago(2)..@today
    @level_data = []
    @levels = AsumiLevel.where(patient_id: params[:id]).where(created_at: Date.current.weeks_ago(2).beginning_of_day...Date.current.end_of_day)
    @level_data = Rails.cache.fetch(@levels) do
      @datedata.map do |day|
        level = @levels.detect { |l| l.created_at.to_date == day }

        if level.present? && level.tweet_count != 0 && level.asumi_count.present?
          level.asumi_count * 100 / level.tweet_count
        else
          0
        end
      end
    end
    gon.leveldata = @level_data
    gon.datedata = @datedata.map { |d| d.prev_day.month.to_s + "/" + d.prev_day.day.to_s }
  end
end
