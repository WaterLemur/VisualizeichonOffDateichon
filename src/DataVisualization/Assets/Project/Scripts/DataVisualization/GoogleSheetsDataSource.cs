using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Networking;


public class GoogleSheetsDataSource : MonoBehaviour
{
    [SerializeField]
    private string csvUrl;

    private void Start()
    {
        Debug.Log("GoogleSheetsDataSource STARTED");

        StartCoroutine(Download());
    }

    private IEnumerator Download()
    {
        Debug.Log("Downloading Google Sheet...");

        using UnityWebRequest request = UnityWebRequest.Get(csvUrl);

        yield return request.SendWebRequest();

        if (request.result != UnityWebRequest.Result.Success)
        {
            Debug.LogError(
                $"Google Sheets request failed: {request.error}"
            );

            yield break;
        }

        string csv = request.downloadHandler.text;

        Debug.Log("Google Sheets data received!");
        Debug.Log(csv);














        // Clear out the raw string variable and parse
        List<DataRecord> records = CSVParser.Parse(csv);
        Debug.Log($"Loaded {records.Count} records.");

        // FIND AND FEED THE FILTER MANAGER (This pushes the data down the pipeline!)
        FilterManager filterManager = FindFirstObjectByType<FilterManager>();
        if (filterManager != null)
        {
            filterManager.InitializeData(records);
        }
        else
        {
            Debug.LogError("Could not find FilterManager in the scene!");
        }
    }
}