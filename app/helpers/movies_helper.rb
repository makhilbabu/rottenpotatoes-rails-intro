module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  def helper_checking(column)
    if (params[:sort_by].to_s == column)
      return 'hilite';
    else
      return nil;
    end
  end
end
