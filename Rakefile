task default: %w[release_test watchdog_test]

task :release_test do
  sh 'test/release.test'
end

task :watchdog_test do
  sh 'test/watchdog.test'
end
