using UnityEngine;


public class Scene_DataView : Scene
{
    [Header("REFERENCES")]
    [Header("Main Menu")]
    [SerializeField] GameObject menu_DataBases;
    [SerializeField] GameObject menu_Maps;
    [SerializeField] GameObject menu_Graphs;

    [Header("DataBases")]
    [SerializeField] GameObject dataBase_A;
    [SerializeField] GameObject dataBase_B;

    [Header("Maps")]
    [SerializeField] GameObject map_Location;
    [SerializeField] GameObject map_Superposed;
    [SerializeField] GameObject map_Barley;
    [SerializeField] GameObject map_Soldiers;

    [Header("Graphs")]
    [SerializeField] GameObject graph_BarsPercent_All;
    [SerializeField] GameObject graph_BarsTotal_Grouped;
    [SerializeField] GameObject graph_BarsTotal_Duo;
    [SerializeField] GameObject graph_BarsTotal;
    [SerializeField] GameObject graph_Tendency_Barley;
    [SerializeField] GameObject graph_Tendency_Soldiers;
    [SerializeField] GameObject graph_Pie_Barley;
    [SerializeField] GameObject graph_Pie_Soldiers;


    // Start is called before the first frame update
    void Start()
    {
        base.Start();
        
        DeactivateObjects();
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void DeactivateObjects()
    {
        menu_DataBases.SetActive(false);
        menu_Maps.SetActive(false);
        menu_Graphs.SetActive(false);

        dataBase_A.SetActive(false);
        dataBase_B.SetActive(false);

        map_Location.SetActive(false);
        map_Superposed.SetActive(false);
        map_Barley.SetActive(false);
        map_Soldiers.SetActive(false);

        graph_BarsPercent_All.SetActive(false);
        graph_BarsTotal_Grouped.SetActive(false);
        graph_BarsTotal_Duo.SetActive(false);
        graph_BarsTotal.SetActive(false);
        graph_Tendency_Barley.SetActive(false);
        graph_Tendency_Soldiers.SetActive(false);
        graph_Pie_Barley.SetActive(false);
        graph_Pie_Soldiers.SetActive(false);
    }


    public void ClickedBtn(GameObject btn)
    {
        activeObject.SetActive(false);
        
        btn.SetActive(true);
        activeObject = btn;
    }

    // BUTTONS
    // Main Menu
    public void Btn_DataBases()
    {
        Debug.Log("CLICKED: DataBase");
    }
    public void Btn_Maps()
    {
        Debug.Log("CLICKED: Maps");
    }
    public void Btn_Graphs()
    {
        Debug.Log("CLICKED: Graphs");
    }

    // Data Bases
    public void Btn_DataBase_A()
    {
        Debug.Log("CLICKED: DataBase A");
    }
    public void Btn_DataBase_B()
    {
        Debug.Log("CLICKED: DataBase B");
    }

    // Maps
    public void Btn_Map_Location()
    {
        Debug.Log("CLICKED: Map Location");
    }
    public void Btn_Map_Superposed()
    {
        Debug.Log("CLICKED: Map Superposed");
    }
    public void Btn_Map_Barley()
    {
        Debug.Log("CLICKED: Map Barley");
    }
    public void Btn_Map_Soldiers()
    {
        Debug.Log("CLICKED: Map Soldiers");
    }

    // Graphs
    public void Btn_Graph_Percent_All()
    {
        Debug.Log("CLICKED: Graph Percent All");
    }
    public void Btn_Graph_Total_Grouped()
    {
        Debug.Log("CLICKED: Graph Total Grouped");
    }
    public void Btn_Graph_Total_Duo()
    {
        Debug.Log("CLICKED: Graph Total Duo");
    }
    public void Btn_Graph_Total()
    {
        Debug.Log("CLICKED: Graph Total");
    }
    public void Btn_Graph_Tendency_Barley()
    {
        Debug.Log("CLICKED: Graph Tendency Barley");
    }
    public void Btn_Graph_Tendency_Soldiers()
    {
        Debug.Log("CLICKED: Graph Tendency Soldiers");
    }
    public void Btn_Graph_Pie_Barley()
    {
        Debug.Log("CLICKED: Graph Pie Barley");
    }
    public void Btn_Graph_Pie_Soldiers()
    {
        Debug.Log("CLICKED: Graph Pie Soldiers");
    }
}
