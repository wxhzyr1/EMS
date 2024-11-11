import waitingCompontentsTest from './waitingCompontents.test'
import localUnitTest from './LocalUnit.test';

export default function testsuite() {
  localUnitTest();
  waitingCompontentsTest()
}