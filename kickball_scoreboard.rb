class KickballScoreboard
  def initialize
    @outs = 0
    @away_team_score = 0
    @home_team_score = 0

    @first_base = false
    @second_base = false
    @third_base = false
    @hitting_team = "away"
    @runs = 0
  end

  def handle_event(event)
    return if @outs == 3 && @hitting_team == "home"

    if event != "K" && @third_base
      @third_base = false
      @runs += 1
    end

    if ["D", "T", "HR"].include?(event) && @second_base
      @second_base = false
      @runs += 1
    elsif @second_base
      @second_base = false
      @third_base = true
    end

    if event == "S"
      if @first_base
        @first_base = false
        @second_base = true
      end

      @first_base = true
    elsif event == "D"
      if @first_base
        @first_base = false
        @third_base = true
      end

      @second_base = true
    elsif event == "T"
      if @first_base
        @first_base = false
        @runs += 1
      end

      @third_base = true
    elsif event == "HR"
      if @first_base
        @first_base = false
        @runs += 1
      end

      @runs += 1
    elsif event == "K"
      @outs += 1
    end

    if @hitting_team == "home"
      @home_team_score = @runs
    else
      @away_team_score = @runs
    end

    if @outs == 3 && @hitting_team == "away"
      @runs = 0
      @outs = 0
      @first_base = false
      @second_base = false
      @third_base = false
      @hitting_team = "home"
    end
  end

  def get_box_score
    {
        away_team: @away_team_score.to_s,
        home_team: @home_team_score.to_s,
        status: "in progress",
        current_inning: "1",
    }
  end
end
