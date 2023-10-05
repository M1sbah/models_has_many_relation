class ManagementsController < ApplicationController

    def create
        @organization = Organization.find(params[:organization_id])
        @management = @organization.managements.build(management_params)
        respond_to do |format|
            if @management.save
                format.turbo_stream do
                    render turbo_stream: [
                        turbo_stream.replace('managements-list',partial: "managements/managements_list", locals: {managements: @organization.managements}),
                        turbo_stream.replace("form",partial: "managements/form", locals: {url: organization_managements_path(@organization)})
                    ]
                end
            end
        end
    end

    def show
        @management = Management.find(params[:id])
    end

    def destroy
        @management = Management.find(params[:id])
        respond_to do |format|
            if @management.destroy
                format.turbo_stream {render turbo_stream: turbo_stream.remove("management-#{@management.id}")}
            end
        end
    end

    private

    def management_params
        params.require(:management).permit(:name, :contact)
    end

end
