cd example
flutter test --coverage
lcov --list coverage/lcov.info
genhtml coverage/lcov.info --output=coverage