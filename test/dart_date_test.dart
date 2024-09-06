import 'package:dart_date/dart_date.dart';
import 'package:test/test.dart';

void main() {
  group('Getters', () {
    test('timestamp', () {
      expect(DateTimeExtension.unix(0).timestamp, 0);
      expect(DateTimeExtension.parse('1996-03-29T11:11:11.011Z').timestamp,
          828097871011);
    });

    test('isFirstDayOfMonth', () {
      expect(DateTime(2011, 2, 1, 11).isFirstDayOfMonth, true);
      expect(
          DateTimeExtension.parse('November 01 2018, 9:14:29 PM',
                  pattern: 'MMMM dd y, h:mm:ss a')
              .isFirstDayOfMonth,
          true);
      expect(
          DateTimeExtension.parse('November 30 2011, 0:14:29 PM',
                  pattern: 'MMMM dd y, h:mm:ss a')
              .isFirstDayOfMonth,
          false);
    });

    test('isLastDayOfMonth', () {
      expect(DateTime(2011, 2, 1, 11).isLastDayOfMonth, false);
      expect(
          DateTimeExtension.parse('November 01 2018, 9:14:29 PM',
                  pattern: 'MMMM dd y, h:mm:ss a')
              .isLastDayOfMonth,
          false);
      expect(
          DateTimeExtension.parse('November 30 2011, 0:14:29 PM',
                  pattern: 'MMMM dd y, h:mm:ss a')
              .isLastDayOfMonth,
          true);
    });

    test('isLeapYear', () {
      expect(DateTime(2011, 2, 1, 11).isLeapYear, false);
      expect(
          DateTimeExtension.parse('September 12 2012', pattern: 'MMMM dd y')
              .isLeapYear,
          true);
    });

    test('eachDay', () {
      final start = DateTime(2023, 10, 10); // October 10th, 2023
      final end = DateTime(2023, 10, 18); // October 18th, 2023

      expect(start.eachDay(start), orderedEquals([start]));

      // Should produce an Iterable that has the 10th to 18th.
      final toTest = start.eachDay(end);
      final expected = [
        DateTime(2023, 10, 10),
        DateTime(2023, 10, 11),
        DateTime(2023, 10, 12),
        DateTime(2023, 10, 13),
        DateTime(2023, 10, 14),
        DateTime(2023, 10, 15),
        DateTime(2023, 10, 16),
        DateTime(2023, 10, 17),
      ];

      expect(toTest, orderedEquals(expected));

      // Should produce an Iterable that has the 18th to 11th (reverse).
      final toTestReverse = end.eachDay(start);
      final expectedReverse = [
        DateTime(2023, 10, 18),
        DateTime(2023, 10, 17),
        DateTime(2023, 10, 16),
        DateTime(2023, 10, 15),
        DateTime(2023, 10, 14),
        DateTime(2023, 10, 13),
        DateTime(2023, 10, 12),
        DateTime(2023, 10, 11),
      ];

      expect(toTestReverse, orderedEquals(expectedReverse));
    });
  });

  group('Week', () {
    test('getWeek', () {
      expect(DateTime(2005, DateTime.january, 2).getWeek, 1);
    });

    test('getWeekPreviousYear', () {
      expect(DateTime(2005, DateTime.january, 1).getWeek, 53);
    });

    test('getWeekBefore100AD', () {
      expect(DateTime(7, DateTime.december, 30).getISOWeek, 52);
    });

    test('getISOWeek', () {
      expect(DateTime(2005, DateTime.january, 3).getISOWeek, 1);
    });

    test('getISOWeekPreviousYear', () {
      expect(DateTime(2005, DateTime.january, 2).getISOWeek, 53);
    });

    test('ISOWeek - Week compare', () {
      expect(DateTime(1922, DateTime.january, 1).getWeek, 1);
      expect(DateTime(1922, DateTime.january, 1).getISOWeek, 52);
    });

    test('getWeekYear', () {
      expect(DateTime(2004, DateTime.december, 26).getWeekYear, 2005);
    });

    test('startOfWeekYear', () {
      expect(DateTime(2005, DateTime.july, 2).startOfWeekYear,
          DateTime(2004, DateTime.december, 26));
    });

    test('startOfWeekYearBefore100AD', () {
      expect(DateTime(9, DateTime.january, 1).startOfWeekYear,
          DateTime(8, DateTime.december, 28));
    });

    test('startOfISOWeekYear', () {
      expect(DateTime(2005, DateTime.july, 2).startOfISOWeekYear,
          DateTime(2004, DateTime.december, 27));
    });

    test('startOfISOWeekYearOnFirstJanuary', () {
      expect(DateTime(2007, DateTime.february, 10).startOfISOWeekYear,
          DateTime(2007, DateTime.january, 1));
    });

    test('startOfISOWeekYearBefore100AD', () {
      expect(DateTime(9, DateTime.january, 1).startOfISOWeekYear,
          DateTime(8, DateTime.december, 29));
    });

    test('getISOWeeksInYear', () {
      expect(DateTime(2014, DateTime.march, 21).getISOWeeksInYear, 52);
    });

    test('getISOWeeksInYear53Weeks', () {
      expect(DateTime(2015, DateTime.february, 11).getISOWeeksInYear, 53);
    });

    test('getISOWeeksInYearBefore100AD', () {
      expect(DateTime(4, DateTime.january, 4).getISOWeeksInYear, 53);
    });

    test('startOfWeek', () {
      expect(DateTime(2022, DateTime.january, 9).startOfWeek,
          DateTime(2022, DateTime.january, 9).startOfDay);
    });

    test('endOfWeek', () {
      expect(DateTime(2022, DateTime.january, 9).endOfWeek,
          DateTime(2022, DateTime.january, 15).endOfDay);
    });

    test('startOfISOWeek', () {
      expect(DateTime(2022, DateTime.january, 9).startOfISOWeek,
          DateTime(2022, DateTime.january, 3).startOfDay);
    });

    test('endOfISOWeek', () {
      expect(DateTime(2022, DateTime.january, 9).endOfISOWeek,
          DateTime(2022, DateTime.january, 9).endOfDay);
    });

    test('setWeekDay', () {
      final base = DateTime(2022, DateTime.september, 3);
      for (var i = 1; i <= DateTime.daysPerWeek; i++) {
        final date = base.setWeekDay(i);
        expect(date.weekday, i);
      }
    });

    test('endOfMonth', () {
      expect(DateTime(2022, DateTime.january, 9).endOfMonth,
          DateTime(2022, DateTime.january, 31, 23, 59, 59, 999, 999));
    });

    test('isWeekend', () {
      // Saturday and Sunday
      expect(DateTime(2022, DateTime.january, 9).isWeekend, true);
      expect(DateTime(2022, DateTime.january, 8).isWeekend, true);
      // Other days
      expect(DateTime(2022, DateTime.january, 7).isWeekend, false);
      expect(DateTime(2022, DateTime.january, 10).isWeekend, false);
    });
  });
}
