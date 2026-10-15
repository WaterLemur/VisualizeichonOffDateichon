using UnityEngine;

public class ViewManager : MonoBehaviour
{
    public enum View
    {
        Database,
        Map,
        Graphs
    }

    [Header("Views")]
    [SerializeField] private GameObject databaseView;
    [SerializeField] private GameObject mapView;
    [SerializeField] private GameObject graphsView;

    private GameObject activeView;

    private void Start()
    {
        Show(View.Database);
    }

    public void ShowDatabase()
    {
        Show(View.Database);
    }

    public void ShowMap()
    {
        Show(View.Map);
    }

    public void ShowGraphs()
    {
        Show(View.Graphs);
    }

    private void Show(View view)
    {
        GameObject nextView = view switch
        {
            View.Database => databaseView,
            View.Map => mapView,
            View.Graphs => graphsView,
            _ => null
        };

        if (nextView == null)
        {
            Debug.LogError($"ViewManager: Missing GameObject for {view}");
            return;
        }

        if (activeView != null)
            activeView.SetActive(false);

        nextView.SetActive(true);
        activeView = nextView;
    }
}