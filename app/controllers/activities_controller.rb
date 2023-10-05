class ActivitiesController < ApplicationController

    def create
        @management = Management.find(params[:management_id])
        @activity = @management.activities.build(activity_params)
        respond_to do |format|
            if @activity.save
                format.turbo_stream do
                    render turbo_stream: [
                        turbo_stream.replace('activities-list',partial: "activities/activities_list", locals: {activities: @management.activities}),
                        turbo_stream.replace("form",partial: "activities/form", locals: {url: management_activities_path(@management)})
                    ]
                end
            end
        end
    end

    def complete
        @activity = Activity.find(params[:id])
        @activity.status = true
        respond_to do |format|
            if @activity.save
                format.turbo_stream { render turbo_stream: turbo_stream.replace("activity-#{@activity.id}",partial: "activities/activity", locals: {activity: @activity}) }
            end
        end
    end

    private

    def activity_params
        params.require(:activity).permit(:name)
    end

end
