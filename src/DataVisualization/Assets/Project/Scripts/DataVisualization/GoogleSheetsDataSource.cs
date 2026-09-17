using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using UnityEngine;
using UnityEngine.Networking;

public class GoogleSheetsDataSource : MonoBehaviour
{
    [Header("Google Sheet")]

    [SerializeField]
    private string csvUrl;

    [Tooltip("GID of the second sheet containing the historical data.")]
    [SerializeField]
    private string timeDataGid;


    [Header("Loaded Data")]

    [SerializeField]
    private List<CityPosition> cityPositions = new();

    [SerializeField]
    private List<DataRecord> timeData = new();


    public IReadOnlyList<CityPosition> CityPositions =>
        cityPositions;

    public IReadOnlyList<DataRecord> TimeData =>
        timeData;

    public bool IsLoaded { get; private set; }

    public event Action DataLoaded;


    private void Start()
    {
        Debug.Log("GoogleSheetsDataSource STARTED");

        StartCoroutine(DownloadAllData());
    }


    private IEnumerator DownloadAllData()
    {
        if (string.IsNullOrWhiteSpace(csvUrl))
        {
            Debug.LogError(
                "GoogleSheetsDataSource: csvUrl has not been assigned."
            );

            yield break;
        }


        if (string.IsNullOrWhiteSpace(timeDataGid))
        {
            Debug.LogError(
                "GoogleSheetsDataSource: timeDataGid has not been assigned."
            );

            yield break;
        }


        // ========================================================
        // FIRST SHEET
        // City positions
        //
        // CIUDAD | LAT | LON
        // ========================================================

        Debug.Log(
            "Downloading city positions..."
        );

        yield return DownloadCsv(
            csvUrl,
            ParsePositionsCsv
        );


        // ========================================================
        // SECOND SHEET
        // Historical data
        //
        // AÑO | CIUDAD | CEBADA (GUR) | SOLDADOS
        // ========================================================

        string timeDataUrl =
            $"{csvUrl}&gid={timeDataGid}";


        Debug.Log(
            "Downloading historical data..."
        );

        yield return DownloadCsv(
            timeDataUrl,
            ParseTimeDataCsv
        );


        // ========================================================
        // FINISHED
        // ========================================================

        IsLoaded = true;

        Debug.Log(
            $"Google Sheets loaded successfully.\n" +
            $"Cities: {cityPositions.Count}\n" +
            $"Records: {timeData.Count}"
        );


        // ========================================================
        // SEND TO FILTER MANAGER
        // ========================================================

        FilterManager filterManager =
            FindFirstObjectByType<FilterManager>();


        if (filterManager != null)
        {
            filterManager.InitializeData(
                timeData
            );
        }
        else
        {
            Debug.LogError(
                "Could not find FilterManager in the scene!"
            );
        }


        DataLoaded?.Invoke();
    }


    // ============================================================
    // DOWNLOAD
    // ============================================================

    private IEnumerator DownloadCsv(
        string url,
        Action<string> onSuccess)
    {
        using UnityWebRequest request =
            UnityWebRequest.Get(url);

        yield return request.SendWebRequest();


        if (request.result != UnityWebRequest.Result.Success)
        {
            Debug.LogError(
                $"Google Sheets request failed:\n" +
                $"{request.error}\n" +
                $"URL: {url}"
            );

            yield break;
        }


        string csv =
            request.downloadHandler.text;


        if (string.IsNullOrWhiteSpace(csv))
        {
            Debug.LogError(
                $"Google Sheets returned an empty CSV.\n" +
                $"URL: {url}"
            );

            yield break;
        }


        onSuccess?.Invoke(csv);
    }


    // ============================================================
    // FIRST SHEET
    // CITY POSITIONS
    // ============================================================

    private void ParsePositionsCsv(string csv)
    {
        cityPositions.Clear();

        List<string[]> rows =
            ParseCsv(csv);


        if (rows.Count == 0)
        {
            Debug.LogError(
                "Positions sheet contains no rows."
            );

            return;
        }


        // Skip header.
        for (int i = 1; i < rows.Count; i++)
        {
            string[] row = rows[i];


            if (row.Length < 3)
                continue;


            string city =
                row[0].Trim();


            if (string.IsNullOrWhiteSpace(city))
                continue;


            if (!TryParseFloat(
                    row[1],
                    out float latitude))
            {
                Debug.LogWarning(
                    $"Invalid latitude for '{city}'."
                );

                continue;
            }


            if (!TryParseFloat(
                    row[2],
                    out float longitude))
            {
                Debug.LogWarning(
                    $"Invalid longitude for '{city}'."
                );

                continue;
            }


            cityPositions.Add(
                new CityPosition
                {
                    city = city,
                    latitude = latitude,
                    longitude = longitude
                }
            );
        }


        Debug.Log(
            $"Parsed {cityPositions.Count} city positions."
        );
    }


    // ============================================================
    // SECOND SHEET
    // HISTORICAL DATA
    //
    // AÑO | CIUDAD | CEBADA (GUR) | SOLDADOS
    //
    // IMPORTANT:
    //
    // Blank AÑO is NOT inherited.
    // Blank AÑO rows are skipped.
    // ============================================================

    private void ParseTimeDataCsv(string csv)
    {
        timeData.Clear();

        List<string[]> rows =
            ParseCsv(csv);


        if (rows.Count == 0)
        {
            Debug.LogError(
                "Time data sheet contains no rows."
            );

            return;
        }


        // Skip header.
        for (int i = 1; i < rows.Count; i++)
        {
            string[] row = rows[i];


            if (row.Length < 4)
                continue;


            string yearText =
                row[0].Trim();

            string city =
                row[1].Trim();


            if (string.IsNullOrWhiteSpace(city))
                continue;


            // ====================================================
            // YEAR
            // ====================================================
            //
            // We use a normal int.
            //
            // Blank year = skip the row.
            //
            // There is NO previous-year inheritance.
            // ====================================================

            if (string.IsNullOrWhiteSpace(yearText))
            {
                Debug.LogWarning(
                    $"Blank year on row {i + 1}. " +
                    $"Skipping '{city}'."
                );

                continue;
            }


            if (!int.TryParse(
                    yearText,
                    NumberStyles.Integer,
                    CultureInfo.InvariantCulture,
                    out int year))
            {
                Debug.LogWarning(
                    $"Invalid year on row {i + 1}: '{yearText}'"
                );

                continue;
            }


            // ====================================================
            // BARLEY
            // ====================================================

            float barley = 0f;


            if (!string.IsNullOrWhiteSpace(row[2]))
            {
                if (!TryParseFloat(
                        row[2],
                        out barley))
                {
                    Debug.LogWarning(
                        $"Invalid barley value for " +
                        $"{city} on row {i + 1}."
                    );

                    continue;
                }
            }


            // ====================================================
            // SOLDIERS
            // ====================================================

            float soldiers = 0f;


            if (!string.IsNullOrWhiteSpace(row[3]))
            {
                if (!TryParseFloat(
                        row[3],
                        out soldiers))
                {
                    Debug.LogWarning(
                        $"Invalid soldiers value for " +
                        $"{city} on row {i + 1}."
                    );

                    continue;
                }
            }


            // ====================================================
            // CREATE DataRecord
            // ====================================================

            DataRecord record =
                new DataRecord
                {
                    year = year,
                    city = city
                };


            record.values["CEBADA (GUR)"] =
                barley;

            record.values["SOLDADOS"] =
                soldiers;


            timeData.Add(record);
        }


        Debug.Log(
            $"Parsed {timeData.Count} time-data records."
        );
    }


    // ============================================================
    // FLOAT PARSER
    // ============================================================

    private static bool TryParseFloat(
        string value,
        out float result)
    {
        value =
            value.Trim();


        return float.TryParse(
            value,
            NumberStyles.Float,
            CultureInfo.InvariantCulture,
            out result
        );
    }


    // ============================================================
    // CSV PARSER
    // ============================================================

    private static List<string[]> ParseCsv(string csv)
    {
        List<string[]> rows =
            new List<string[]>();

        List<string> currentRow =
            new List<string>();

        string currentField =
            string.Empty;

        bool insideQuotes =
            false;


        for (int i = 0; i < csv.Length; i++)
        {
            char character =
                csv[i];


            // ----------------------------------------------------
            // QUOTES
            // ----------------------------------------------------

            if (character == '"')
            {
                if (
                    insideQuotes &&
                    i + 1 < csv.Length &&
                    csv[i + 1] == '"'
                )
                {
                    currentField += '"';
                    i++;
                }
                else
                {
                    insideQuotes =
                        !insideQuotes;
                }
            }


            // ----------------------------------------------------
            // COMMA
            // ----------------------------------------------------

            else if (
                character == ',' &&
                !insideQuotes)
            {
                currentRow.Add(
                    currentField
                );

                currentField =
                    string.Empty;
            }


            // ----------------------------------------------------
            // NEW LINE
            // ----------------------------------------------------

            else if (
                (character == '\n' ||
                 character == '\r') &&
                !insideQuotes)
            {
                if (
                    character == '\r' &&
                    i + 1 < csv.Length &&
                    csv[i + 1] == '\n'
                )
                {
                    i++;
                }


                currentRow.Add(
                    currentField
                );

                currentField =
                    string.Empty;


                if (
                    currentRow.Count > 1 ||
                    !string.IsNullOrWhiteSpace(
                        currentRow[0]
                    )
                )
                {
                    rows.Add(
                        currentRow.ToArray()
                    );
                }


                currentRow.Clear();
            }


            // ----------------------------------------------------
            // NORMAL CHARACTER
            // ----------------------------------------------------

            else
            {
                currentField +=
                    character;
            }
        }


        // --------------------------------------------------------
        // FINAL ROW
        // --------------------------------------------------------

        currentRow.Add(
            currentField
        );


        if (
            currentRow.Count > 1 ||
            !string.IsNullOrWhiteSpace(
                currentRow[0]
            )
        )
        {
            rows.Add(
                currentRow.ToArray()
            );
        }


        return rows;
    }
}