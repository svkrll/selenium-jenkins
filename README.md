# selenium
## 123

docker run -it --rm --network=selenoid tests \
  --browser=chrome 

docker run -it --rm --network=selenoid tests \
  -v tests/test_find_elements_opencart.py\
  --browser=firefox 

docker run -it --rm --network=selenoid tests \
  -v tests/test_find_elements_opencart.py\
  --browser=chrome \
  --browser_version=122.0 \
  --headless \
  --selenoid \
  --selenoid_url=http://selenoid:4444/wd/hub \
  --url=http://opencart:8080
