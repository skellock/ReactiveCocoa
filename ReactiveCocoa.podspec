Pod::Spec.new do |s|
  s.name         = "ReactiveCocoa"
  s.version      = "2.0-development"
  s.summary      = "A framework for composing and transforming sequences of values."
  s.homepage     = "https://github.com/ReactiveCocoa/ReactiveCocoa"
  s.author       = { "Josh Abernathy" => "josh@github.com" }
  s.source       = { :git => "https://github.com/skellock/ReactiveCocoa.git", :tag => "v#{s.version}" }
  s.license      = 'Simplified BSD License'
  s.description  = "ReactiveCocoa offers:\n"                                                               \
                   "1. The ability to compose operations on future data.\n"                                \
                   "2. An approach to minimizing state and mutability.\n"                                  \
                   "3. A declarative way to define behaviors and the relationships between properties.\n"  \
                   "4. A unified, high-level interface for asynchronous operations.\n"                     \
                   "5. A lovely API on top of KVO."

  s.requires_arc = true
  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.7'
  s.compiler_flags = '-DOS_OBJECT_USE_OBJC=0'

  s.subspec 'Core' do |sp|
    s.source_files = 'ReactiveCocoaFramework/ReactiveCocoa/**/*.{h,m}'
    s.exclude_files = 'ReactiveCocoaFramework/ReactiveCocoa/RACObjCRuntime.{h,m}'
    s.ios.exclude_files = '**/*{NSButton,AppKit,NSText,NSControl}*'
    s.osx.exclude_files = '**/*{UIAlertView,UIButton,UITableViewCell,UIActionSheet,UIBarButtonItem,UIControl,UIGestureRecognizer,UIText,RACEventTrampoline,RACDelegateProxy}*'
    sp.header_dir = 'ReactiveCocoa'

    sp.dependency 'JRSwizzle', '~> 1.0'

    sp.pre_install do |pod, _|
      pod.source_files.each { |source|
        contents = source.read
        if contents.gsub!(%r{\bReactiveCocoa/(?:\w+/)*(EXT\w+|metamacros)\.h\b}, '\1.h')
          File.open(source, 'w') { |file| file.puts(contents) }
        end
      }
    end
  end

  s.subspec 'fishhook' do |sp|
    sp.source_files = 'external/fishhook/*.{h,c}'
    sp.osx.exclude_files = 'external/fishhook/*.{h,c}'
    sp.dependency 'ReactiveCocoa/Core'
  end

  s.subspec 'RACExtensions' do |sp|
    sp.source_files = 'RACExtensions/*.{h,m}'
    sp.ios.exclude_files = '**/*{NSTask}*'
    sp.dependency 'ReactiveCocoa/Core'
  end

  s.subspec 'no-arc' do |sp|
    sp.source_files = 'ReactiveCocoaFramework/ReactiveCocoa/RACObjCRuntime.{h,m}'
    sp.requires_arc = false
  end

end