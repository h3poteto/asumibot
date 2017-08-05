# coding: utf-8
class PatientsController < ApplicationController
  layout "user"

  # GET /patients
  # GET /patients.json
  def index
    @patients = Patient.includes(:asumi_tweets).rankings.take(10)
    @month_ranking = MonthRanking.includes(:patient).level_order.limit(20)
    @prev_rank = Patient.avail_prev_rankings
    @prev_rank_index = []
    @patients.each_with_index do |p, i|
      if @prev_rank.index(p).present?
        @prev_rank_index[p.id] = @prev_rank.index(p)
      else
        @prev_rank_index[p.id] = 2147483648
      end
    end
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
    @patient = Patient.find(params[:id])
    if @patient.protect
      redirect_to :action => :index and return
    end
    @asumi_tweet = AsumiTweet.where(patient_id: params[:id]).order("tweet_time DESC").limit(25)

    @all_patients = Patient.rankings
    @all_patients.each_with_index do |p, i|
      @ranking = i + 1 if p.id == params[:id].to_i
    end

    @today = Date.current
    @datedata = Date.current.weeks_ago(2)..@today
    @level_data = []
    @datedata.each do | day |
      level = AsumiLevel.where(patient_id: params[:id]).where(created_at: day.beginning_of_day...day.end_of_day )

      if level.present? && level.first.tweet_count != 0 && level.first.asumi_count.present?
        @level_data.push(level.first.asumi_count * 100 / level.first.tweet_count)
      else
        @level_data.push(0)
      end
    end
    gon.leveldata = @level_data
    gon.datedata = @datedata.map{|d| d.prev_day.month.to_s + "/" + d.prev_day.day.to_s }
  end


end
