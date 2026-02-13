require 'redmine'

Redmine::Plugin.register :issue_lifecycle_report do
  name 'İş Hayat Döngüsü - Lifecycle '
  author 'Göktuğ Dal'
  description 'İşlerin durum bazlı bekleme sürelerini gösteren rapor eklentisi.'
  version '1.0.0'

  # Ek özellik : Açılıp kapanılabilirlik
  project_module :issue_lifecycle_report do
    permission :view_lifecycle_report, :lifecycle_report => :index
  end

  menu :project_menu, 
       :issue_lifecycle_report, 
       { :controller => 'lifecycle_report', :action => 'index' }, 
       :caption => 'İş Döngüsü', 
       :after => :issues, 
       :param => :project_id
end