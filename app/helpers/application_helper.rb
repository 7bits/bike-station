module ApplicationHelper
  def breadcrumbs
    @breadcrumbs || [Breadcrumb.new('Stations', stations_path, 'active')]
  end
end
