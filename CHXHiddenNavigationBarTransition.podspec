Pod::Spec.new do |s|
  s.name = "CHXHiddenNavigationBarTransition"
  s.version = "0.1.0"
  s.license = "MIT"
  s.summary = "Deal with navigation bar and status bar animation when some page set navigation bar hidden or change status bar style."
  s.homepage = "https://github.com/cuzv/CHXHiddenNavigationBarTransition"
  s.author = { "Moch Xiao" => "cuzval@gmail.com" }
  s.source = { :git => "https://github.com/cuzv/CHXHiddenNavigationBarTransition.git", :tag => s.version }

  s.ios.deployment_target = "8.0"
  s.source_files = "Sources/*.{h,m}"
  s.requires_arc = true
end
