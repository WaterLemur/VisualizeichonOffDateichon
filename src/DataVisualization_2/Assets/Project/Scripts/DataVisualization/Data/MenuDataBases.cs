using UnityEngine;


public class MenuDataBases : MonoBehaviour
{
    [SerializeField] GameObject dataBaseA;
    [SerializeField] GameObject dataBaseB;

    void Start()
    {
        ClickedDataBaseA();
    }


    public void ClickedDataBaseA()
    {
        dataBaseA.SetActive(true);
        dataBaseB.SetActive(false);
    }

    public void ClickedDataBaseB()
    {
        dataBaseA.SetActive(false);
        dataBaseB.SetActive(true);
    }
}
