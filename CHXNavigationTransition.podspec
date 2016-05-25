Pod::Spec.new do |s|
  s.name = "CHXNavigationTransition"
  s.version = "0.4.0"
  s.license = "MIT"
  s.summary = "Deal with navigation bar and status bar animation when some page set navigation bar hidden or change status bar style."
  s.homepage = "https://github.com/cuzv/CHXNavigationTransition"
  s.author = { "Moch Xiao" => "cuzval@gmail.com" }
  s.source = { :git => "https://github.com/cuzv/CHXNavigationTransition.git", :tag => s.version }

  s.ios.deployment_target = "8.0"
  s.source_files = "Sources/*.{h,m}"
  s.requires_arc = true
end
