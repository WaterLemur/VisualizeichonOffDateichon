using UnityEngine;


public interface IDataVisualization
{
    void SetData(DataSet data);
    void Refresh();
    void Clear();
}


public class VisualizationManager : MonoBehaviour
{
    private DataSet currentData;
    private DataSet filteredData;

    private IDataVisualization currentVisualization;

    public void SetData(DataSet data)
    {
        currentData = data;
        ApplyFilters();
    }

    public void SetVisualization(IDataVisualization visualization)
    {
        currentVisualization = visualization;
        currentVisualization.SetData(filteredData);
        currentVisualization.Refresh();
    }

    public void ApplyFilters()
    {
        currentVisualization?.SetData(filteredData);
        currentVisualization?.Refresh();
    }
}


[CreateAssetMenu]
public class VisualizationDefinition : ScriptableObject
{
    public string id;
    public string displayName;
    public VisualizationType type;
    public Sprite preview;
    public GameObject prefab;
}


public enum VisualizationType
{
    PNG,
    BarChart,
    LineChart,
    PieChart,
    Model3D
}