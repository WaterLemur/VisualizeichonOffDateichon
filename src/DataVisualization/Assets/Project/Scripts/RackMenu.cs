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

    [Header("References")]  
    [SerializeField] List<GameObject> listAkkad;
    [SerializeField] List<GameObject> listUr;
    [SerializeField] List<GameObject> listUruk;

    [Space(5)]
    [SerializeField] List<GameObject> listBarley;
    [SerializeField] List<GameObject> listSoldiers;


    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }


    public void BtnHelp()
    {
        
    }
    public void BtnInfo()
    {
        
    }
    public void BtnCityAkkad()
    {
        isAkkad = !isAkkad;

        foreach (GameObject obj in listAkkad)
        {
            obj.SetActive(isAkkad);
        }
    }
    public void BtnCityUr()
    {
        isUr = !isUr;

        foreach (GameObject obj in listUr)
        {
            obj.SetActive(isUr);
        }
    }
    public void BtnCityUruk()
    {
        isUruk = !isUruk;

        foreach (GameObject obj in listUruk)
        {
            obj.SetActive(isUruk);
        }
    }
    public void BtnResourceBarley()
    {
        isBarley = !isBarley;

        foreach (GameObject obj in listBarley)
        {
            obj.SetActive(isBarley);
        }
    }
    public void BtnResourceSoldiers()
    {
        isSoldiers = !isSoldiers;

        foreach (GameObject obj in listSoldiers)
        {
            obj.SetActive(isSoldiers);
        }
    }
}
