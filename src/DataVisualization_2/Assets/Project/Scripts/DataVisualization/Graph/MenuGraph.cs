using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class MenuGraph : MonoBehaviour
{
    [SerializeField] int currentGraph = 1;
    [SerializeField] List<GameObject> graphs;

    // Start is called before the first frame update
    void Start()
    {
        DisableGraphs();
        if (graphs.Count > 0 && graphs[0] != null)
        {
            graphs[0].SetActive(true);
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void DisableGraphs()
    {
        foreach (var graph in graphs)
        {
            if (graph != null && graph.activeSelf) graph.SetActive(false);
        }
    }

    void EnableGraph(GameObject toEnable)
    {
        DisableGraphs();
        if (toEnable != null) toEnable.SetActive(true);
    }

    // Pass the actual graph number here (e.g., 1 for Graph 1, 8 for Graph 8)
    public void SwitchToGraph(int graphNumber)
    {
        // Convert user number (1-8) to list index (0-7)
        int graphIndex = graphNumber - 1;

        // Safety check to make sure the index is valid
        if (graphIndex < 0 || graphIndex >= graphs.Count) return;

        EnableGraph(graphs[graphIndex]);
        currentGraph = graphNumber;
    }
}
