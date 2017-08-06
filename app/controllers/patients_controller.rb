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

    if @patient.protect
      redirect_to action: :index and return
    end

    @all_patients = Patient.rankings

    # for js graph
    @levels = AsumiLevel.where(patient_id: params[:id]).where(created_at: Date.current.weeks_ago(2).beginning_of_day...Date.current.end_of_day)
    cache @levels do
      @today = Date.current
      @datedata = Date.current.weeks_ago(2)..@today
      @level_data = []
      @datedata.each do |day|
        level = @levels.detect { |l| l.created_at.to_date == day }

        if level.present? && level.tweet_count != 0 && level.asumi_count.present?
          @level_data.push(level.asumi_count * 100 / level.tweet_count)
        else
          @level_data.push(0)
        end
      end
      gon.leveldata = @level_data
      gon.datedata = @datedata.map { |d| d.prev_day.month.to_s + "/" + d.prev_day.day.to_s }
    end
  end
end
