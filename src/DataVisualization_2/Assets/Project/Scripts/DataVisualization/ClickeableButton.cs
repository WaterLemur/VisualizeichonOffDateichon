using UnityEngine;

public enum ButtonType
{
    Help,
    Info,

    // Cities
    Akkad,
    Ur,
    Uruk,

    // Resources
    Barley,
    Soldiers
}
public class ClickableButton : MonoBehaviour
{
    [SerializeField] ButtonType type;
    [SerializeField] RackMenu rackMenu;


    void OnMouseDown()
    {
        Clicked();
    }

    void Clicked()
    {
        switch (type)
        {
            case ButtonType.Help:
                rackMenu.BtnHelp();
                break;

            case ButtonType.Info:
                rackMenu.BtnInfo();
                break;

            case ButtonType.Akkad:
                rackMenu.BtnCityAkkad();
                break;
            
            case ButtonType.Ur:
                rackMenu.BtnCityUr();
                break;

            case ButtonType.Uruk:
                rackMenu.BtnCityUruk();
                break;


            case ButtonType.Barley:
                rackMenu.BtnResourceBarley();
                break;

            case ButtonType.Soldiers:
                rackMenu.BtnResourceSoldiers();
                break;
        }
    }
}
