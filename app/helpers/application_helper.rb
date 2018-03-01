module ApplicationHelper
    def helper_checking(column)
        if (params[:sort_by].to_s == column)
            return 'hilite';
        else
            return nil;
        end
    end
end
