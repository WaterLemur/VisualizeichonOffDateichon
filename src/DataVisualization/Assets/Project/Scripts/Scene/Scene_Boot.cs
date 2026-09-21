using UnityEngine;
using UnityEngine.SceneManagement;
using System.Collections;

public class Scene_Boot : MonoBehaviour
{
    void Start()
    {
        StartCoroutine(Boot());
    }

    private IEnumerator Boot()
    {
        // Load Persistent first
        AsyncOperation persistent = SceneManager.LoadSceneAsync(
            "Persistent",
            LoadSceneMode.Additive
        );

        while (!persistent.isDone)
        {
            yield return null;
        }

        // Now Persistent is fully loaded and ScenePersistent.Instance exists

        yield return StartCoroutine(
            LoadAndActivate(SceneList.Intro.ToString())
        );
    }

    private IEnumerator LoadAndActivate(string sceneName)
    {
        AsyncOperation op = SceneManager.LoadSceneAsync(
            sceneName,
            LoadSceneMode.Additive
        );

        while (!op.isDone)
        {
            yield return null;
        }

        // Small delay to ensure the scene is fully registered
        yield return null;

        UnityEngine.SceneManagement.Scene loadedScene =
            SceneManager.GetSceneByName(sceneName);

        if (loadedScene.IsValid())
        {
            SceneManager.SetActiveScene(loadedScene);
        }

        ClearConsole();
    }

    void ClearConsole()
    {
#if UNITY_EDITOR
        System.Type.GetType("UnityEditor.LogEntries, UnityEditor.dll")
            .GetMethod("Clear")
            .Invoke(null, null);
#endif
    }
}