using System;
using System.Collections.Generic;
using System.Globalization;

public static class CSVParser
{
    public static List<DataRecord> Parse(string csv)
    {
        List<DataRecord> records = new List<DataRecord>();

        string[] lines = csv.Split(
            new[] { '\r', '\n' },
            StringSplitOptions.RemoveEmptyEntries
        );

        if (lines.Length < 2)
            return records;

        // Header
        string[] headers = lines[0].Split(',');

        int currentYear = 0;

        for (int i = 1; i < lines.Length; i++)
        {
            string[] columns = lines[i].Split(',');

            if (columns.Length < 2)
                continue;

            // -------------------------
            // YEAR
            // -------------------------
            if (!string.IsNullOrWhiteSpace(columns[0]))
            {
                currentYear = int.Parse(
                    columns[0],
                    CultureInfo.InvariantCulture
                );
            }

            // No year has been established yet.
            if (currentYear == 0)
                continue;

            // -------------------------
            // CITY
            // -------------------------
            string city = columns[1].Trim();

            if (string.IsNullOrWhiteSpace(city))
                continue;

            DataRecord record = new DataRecord();
            record.year = currentYear;
            record.city = city;

            // FIX: Ensure the dictionary is initialized so we don't hit a NullReferenceException
            if (record.values == null)
            {
                record.values = new Dictionary<string, float>();
            }

            // -------------------------
            // VALUES
            // -------------------------
            for (int column = 2; column < columns.Length; column++)
            {
                // Safety check: Make sure the header array actually has a column for this index
                if (column >= headers.Length)
                    continue;

                string header = headers[column].Trim();
                string valueString = columns[column].Trim();

                // Empty spreadsheet cell
                if (string.IsNullOrWhiteSpace(valueString))
                    continue;

                if (float.TryParse(
                    valueString,
                    NumberStyles.Float,
                    CultureInfo.InvariantCulture,
                    out float value))
                {
                    record.values[header] = value;
                }
            }

            records.Add(record);
        }

        return records;
    }
}
