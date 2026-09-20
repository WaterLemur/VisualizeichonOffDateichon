using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RackMenu : MonoBehaviour
{
    [Header("Cities")]
    [SerializeField] bool isAkkad;
    [SerializeField] bool isUr;
    [SerializeField] bool isUruk;

    [Header("Resources")]
    [SerializeField] bool isBarley;
    [SerializeField] bool isSoldiers;


    [Header("REFERENCES")]

    [Header("Buttons")]
    [SerializeField] GameObject btnHelp;
    [SerializeField] GameObject btnInfo;
    [Space(5)]

    [SerializeField] GameObject btnAkkad;
    [SerializeField] GameObject btnUr;
    [SerializeField] GameObject btnUruk;
    [Space(5)]

    [SerializeField] Material btnOn;
    [SerializeField] Material btnOff;
    [Space(5)]

    [SerializeField] GameObject btnBarley;
    [SerializeField] GameObject btnSoldiers;


    [Header("Data bases")]
    [SerializeField] GameObject databaseA_akkad;
    [SerializeField] GameObject databaseA_ur;
    [SerializeField] GameObject databaseA_ururk;
    [Space(5)]

    [SerializeField] GameObject databaseB_akkad;
    [SerializeField] GameObject databaseB_ur;
    [SerializeField] GameObject databaseC_ururk;

    [Header("Maps")]
    [SerializeField] GameObject mapRivers;
    [SerializeField] GameObject mapRoads;

    [Space(5)]
    [SerializeField] GameObject mapAkkad;
    [SerializeField] GameObject mapUr;
    [SerializeField] GameObject mapUruk;

    [Header("Graphs Bars")]

    // Graph Bars A
    [SerializeField] GameObject graph_barsA_akkad_barley;
    [SerializeField] GameObject graph_barsA_akkad_soldiers;

    [SerializeField] GameObject graph_barsA_ur_barley;
    [SerializeField] GameObject graph_barsA_ur_soldiers;

    [SerializeField] GameObject graph_barsA_uruk_barley;
    [SerializeField] GameObject graph_barsA_uruk_soldiers;

    [Space(5)]

    // Graph Bars B
    [SerializeField] GameObject graph_barsB_akkad;
    [SerializeField] GameObject graph_barsB_ur;
    [SerializeField] GameObject graph_barsB_uruk;


    [Header("Graphs Donut")]

    // Graph Donuts
    [SerializeField] GameObject graph_donutA_barley;
    [SerializeField] GameObject graph_donutB_soldiers;

    [Header("Graphs Tendency")]

    // Graph Tendency A Barley
    [SerializeField] GameObject graph_tendencyA_akkad;
    [SerializeField] GameObject graph_tendencyA_ur;
    [SerializeField] GameObject graph_tendencyA_uruk;

    [Space(5)]

    // Graph Tendency B Soldiers
    [SerializeField] GameObject graph_tendencyB_akkad;
    [SerializeField] GameObject graph_tendencyB_ur;
    [SerializeField] GameObject graph_tendencyB_uruk;


    private void Start()
    {

    }


    public void BtnHelp()
    {
        Debug.Log("Clicked: Help");
    }


    public void BtnInfo()
    {
        Debug.Log("Clicked: Info");
    }


    public void BtnCityAkkad()
    {
        Debug.Log("Clicked: Akkad");

        isAkkad = !isAkkad;


        //Map
        if(!mapAkkad.activeSelf) mapAkkad.SetActive(true);
        else mapAkkad.SetActive(false);


        if (isBarley) 
        { 
            //Graph Bars A Grouped
            if(!graph_barsA_akkad_barley.activeSelf) graph_barsA_akkad_barley.SetActive(true);
            else graph_barsA_akkad_barley.SetActive(false);

            //Graph Bars B Percent
            if(!graph_barsB_akkad.activeSelf) graph_barsB_akkad.SetActive(true);
            else graph_barsB_akkad.SetActive(false);

            //Graph Tendency A Barley
            if(!graph_tendencyA_akkad.activeSelf) graph_tendencyA_akkad.SetActive(true);
            else graph_tendencyA_akkad.SetActive(false);
        } 
        if (isSoldiers)
        {
            //Graph Bars A Grouped
            if(!graph_barsA_akkad_soldiers.activeSelf) graph_barsA_akkad_soldiers.SetActive(true);
            else graph_barsA_akkad_soldiers.SetActive(false);

            //Graph Bars B Percent
            if(!graph_barsB_akkad.activeSelf) graph_barsB_akkad.SetActive(true);
            else graph_barsB_akkad.SetActive(false);

            //Graph Tendency B Soldiers
            if(!graph_tendencyB_akkad.activeSelf) graph_tendencyB_akkad.SetActive(true);
            else graph_tendencyB_akkad.SetActive(false);
        }
    }


    public void BtnCityUr()
    {
        Debug.Log("Clicked: Ur");

        isUr = !isUr;


        //Map
        if(!mapUr.activeSelf) mapUr.SetActive(true);
        else mapUr.SetActive(false);


        if (isBarley) 
        { 
            //Graph Bars A Grouped
            if(!graph_barsA_ur_barley.activeSelf) graph_barsA_ur_barley.SetActive(true);
            else graph_barsA_ur_barley.SetActive(false);

            //Graph Bars B Percent
            if(!graph_barsB_ur.activeSelf) graph_barsB_ur.SetActive(true);
            else graph_barsB_ur.SetActive(false);

            //Graph Tendency A Barley
            if(!graph_tendencyA_ur.activeSelf) graph_tendencyA_ur.SetActive(true);
            else graph_tendencyA_ur.SetActive(false);
        } 
        if (isSoldiers)
        {
            //Graph Bars A Grouped
            if(!graph_barsA_ur_soldiers.activeSelf) graph_barsA_ur_soldiers.SetActive(true);
            else graph_barsA_ur_soldiers.SetActive(false);

            //Graph Bars B Percent
            if(!graph_barsB_ur.activeSelf) graph_barsB_ur.SetActive(true);
            else graph_barsB_ur.SetActive(false);

            //Graph Tendency B Soldiers
            if(!graph_tendencyB_ur.activeSelf) graph_tendencyB_ur.SetActive(true);
            else graph_tendencyB_ur.SetActive(false);
        }
    }


    public void BtnCityUruk()
    {
        Debug.Log("Clicked: Uruk");

        isUruk = !isUruk;


        //Map
        if(!mapUruk.activeSelf) mapUruk.SetActive(true);
        else mapUruk.SetActive(false);


        if (isBarley) 
        { 
            //Graph Bars A Grouped
            if(!graph_barsA_uruk_barley.activeSelf) graph_barsA_uruk_barley.SetActive(true);
            else graph_barsA_uruk_barley.SetActive(false);

            //Graph Bars B Percent
            if(!graph_barsB_uruk.activeSelf) graph_barsB_uruk.SetActive(true);
            else graph_barsB_uruk.SetActive(false);

            //Graph Tendency A Barley
            if(!graph_tendencyA_uruk.activeSelf) graph_tendencyA_uruk.SetActive(true);
            else graph_tendencyA_uruk.SetActive(false);
        } 
        if (isSoldiers)
        {
            //Graph Bars A Grouped
            if(!graph_barsA_uruk_soldiers.activeSelf) graph_barsA_uruk_soldiers.SetActive(true);
            else graph_barsA_uruk_soldiers.SetActive(false);

            //Graph Bars B Percent
            if(!graph_barsB_uruk.activeSelf) graph_barsB_uruk.SetActive(true);
            else graph_barsB_uruk.SetActive(false);

            //Graph Tendency B Soldiers
            if(!graph_tendencyB_uruk.activeSelf) graph_tendencyB_uruk.SetActive(true);
            else graph_tendencyB_uruk.SetActive(false);
        }
    }


    public void BtnResourceBarley()
    {
        Debug.Log("Clicked: Barley");

        isBarley = !isBarley;


        if(isAkkad)
        {
            //Graph Bars A Grouped
            if(!graph_barsA_akkad_barley.activeSelf) graph_barsA_akkad_barley.SetActive(true);
            else graph_barsA_akkad_barley.SetActive(false);

            //Graph Bars B Percent
            if(!graph_barsB_akkad.activeSelf) graph_barsB_akkad.SetActive(true);
            else graph_barsB_akkad.SetActive(false);

            //Graph Tendency A Barley
            if(!graph_tendencyA_akkad.activeSelf) graph_tendencyA_akkad.SetActive(true);
            else graph_tendencyA_akkad.SetActive(false);
        }
        if(isUr)
        {
            //Graph Bars A Grouped
            if(!graph_barsA_ur_barley.activeSelf) graph_barsA_ur_barley.SetActive(true);
            else graph_barsA_ur_barley.SetActive(false);

            //Graph Bars B Percent
            if(!graph_barsB_ur.activeSelf) graph_barsB_ur.SetActive(true);
            else graph_barsB_ur.SetActive(false);

            //Graph Tendency A Barley
            if(!graph_tendencyA_ur.activeSelf) graph_tendencyA_ur.SetActive(true);
            else graph_tendencyA_ur.SetActive(false);
        }
        if(isUruk)
        {
            //Graph Bars A Grouped
            if(!graph_barsA_uruk_barley.activeSelf) graph_barsA_uruk_barley.SetActive(true);
            else graph_barsA_uruk_barley.SetActive(false);

            //Graph Bars B Percent
            if(!graph_barsB_uruk.activeSelf) graph_barsB_uruk.SetActive(true);
            else graph_barsB_uruk.SetActive(false);

            //Graph Tendency A Barley
            if(!graph_tendencyA_uruk.activeSelf) graph_tendencyA_uruk.SetActive(true);
            else graph_tendencyA_uruk.SetActive(false);
        }
    }


    public void BtnResourceSoldiers()
    {
        Debug.Log("Clicked: Soldiers");

        isSoldiers = !isSoldiers;


        if(isAkkad)
        {
            //Graph Bars A Grouped
            if(!graph_barsA_akkad_soldiers.activeSelf) graph_barsA_akkad_soldiers.SetActive(true);
            else graph_barsA_akkad_soldiers.SetActive(false);

            //Graph Bars B Percent
            if(!graph_barsB_akkad.activeSelf) graph_barsB_akkad.SetActive(true);
            else graph_barsB_akkad.SetActive(false);

            //Graph Tendency A Barley
            if(!graph_tendencyB_akkad.activeSelf) graph_tendencyB_akkad.SetActive(true);
            else graph_tendencyB_akkad.SetActive(false);
        }
        if(isUr)
        {
            //Graph Bars A Grouped
            if(!graph_barsA_ur_barley.activeSelf) graph_barsA_ur_barley.SetActive(true);
            else graph_barsA_ur_barley.SetActive(false);

            //Graph Bars B Percent
            if(!graph_barsB_ur.activeSelf) graph_barsB_ur.SetActive(true);
            else graph_barsB_ur.SetActive(false);

            //Graph Tendency A Barley
            if(!graph_tendencyB_ur.activeSelf) graph_tendencyB_ur.SetActive(true);
            else graph_tendencyB_ur.SetActive(false);
        }
        if(isUruk)
        {
            //Graph Bars A Grouped
            if(!graph_barsA_uruk_barley.activeSelf) graph_barsA_uruk_barley.SetActive(true);
            else graph_barsA_uruk_barley.SetActive(false);

            //Graph Bars B Percent
            if(!graph_barsB_uruk.activeSelf) graph_barsB_uruk.SetActive(true);
            else graph_barsB_uruk.SetActive(false);

            //Graph Tendency A Barley
            if(!graph_tendencyB_uruk.activeSelf) graph_tendencyB_uruk.SetActive(true);
            else graph_tendencyB_uruk.SetActive(false);
        }
    }
}