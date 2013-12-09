class PatientsController < ApplicationController
  layout "user"
  # GET /patients
  # GET /patients.json
  def index
    @patients = Patient.order("level DESC").take(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @patients }
    end
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
    
    @patient = Patient.find(params[:id])
    @search = AsumiTweet.where(patient_id: params[:id]).search(params[:q])
    if params[:day].present?
      from = Time.mktime(Date.today.year, Date.today.month, params[:day].to_i)
      to = from.end_of_day
      @asumi_tweet = @search.result.where(tweet_time: from...to).order("tweet_time DESC").page(params[:page]).per(25)
    else
      @asumi_tweet = @search.result.order("tweet_time DESC").page(params[:page]).per(25)
    end

    @all_patients = Patient.order("level DESC")
    @all_patients.each_with_index do |p, i|
      @ranking = i + 1 if p.id == params[:id].to_i
    end

    @first_day = Date.today.beginning_of_month
    @last_day = Date.today.end_of_month
    @today = Date.today
    @datedata = Date.today.weeks_ago(2)..@today
    @level_data = []
    @datedata.each do | day |
      level = AsumiLevel.where(patient_id: params[:id]).where(created_at: day.beginning_of_day...day.end_of_day )

      if level.present?
        @level_data.push(level.first.asumi_count * 100 / level.first.tweet_count)
      else
        @level_data.push(0)
      end
    end
    gon.leveldata = @level_data
    gon.datedata = @datedata.map{|d| d.prev_day.month.to_s + "/" + d.prev_day.day.to_s }
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @patient }
    end
  end


end
