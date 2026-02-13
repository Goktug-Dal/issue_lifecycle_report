class LifecycleReportController < ApplicationController
  before_action :find_project_by_project_id

  def index
    @issues = @project.issues.includes(:status, 
                      :author, :category,
                      :assigned_to,
                      journals: :details).order(id: :desc)

    @report_data = []

    @issues.each do |issue| # for loop to get each issue
      times = calculate_time(issue)

      if issue.category
        categ_name = issue.category.name
      else
        categ_name = "Kategorisiz"
      end

      if issue.assigned_to
        assign_name = issue.assigned_to.name
      else
        assign_name = "Atanmamış"
      end


      data = {issue: issue,
        durations: times,
        total_time: times.values.sum,
        category_name: categ_name,
        assigned_to_name: assign_name }

      @report_data << data
    end
    #end of for loop

    # to sort
    if params[:sort] == 'total_time'
      @report_data.sort_by! { |d| -d[:total_time] } # to sort time
    elsif params[:sort] == 'category'
      @report_data.sort_by! { |d| d[:category_name] } # sort with categ name
    elsif params[:sort] == 'user'
      @report_data.sort_by! { |d| d[:assigned_to_name] } # sort with user name
    end
  end

  # --------------
  private
  def calculate_time(issue)
    hour = 3600.0

    times = Hash.new(0)
    prev = issue.created_on

    # filter the status
    issue.journals.each do |journal|
      journal.details.each do |detail|
        if detail.prop_key == 'status_id'
          # change the time if a change happens
          hours = (journal.created_on - prev) / hour

          # change status
          if detail.old_value
            old_status = IssueStatus.find_by(id: detail.old_value)
            if old_status
              status_name = old_status.name
            else
              status_name = "Silimiş Statü"
            end

            times[status_name] += hours
          end

          prev = journal.created_on
        end
      end
    end

    #current time
    current = (Time.now - prev) / hour
    times[issue.status.name] += current
    return times
  end
end