Pod::Spec.new do |s|
s.name         = "ExpandingDataSource"
s.version      = "0.0.1"
s.summary      = "A datasource and delegate for create a expand table view"

s.description  = %{
    ExpandingDataSource is a UITableView's datasource, you can create a expand table by extending this datasource.
  }

s.homepage     = "https://github.com/zzycami/ExpandingDataSource"
s.license      = 'MIT'
s.author       = { "zzycami" => "zzycami@foxmail.com" }
s.platform     = :ios, '7.0'

s.source       = { :git => "https://github.com/zzycami/ExpandingDataSource.git", :tag => s.version.to_s }
s.source_files  = 'Class/*.{h,m}'

s.frameworks   = 'Foundation', 'UIKit'
end