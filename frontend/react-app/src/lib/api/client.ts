import axios, { AxiosInstance } from "axios"

let client: AxiosInstance

if (process.env.REACT_APP_NODE_ENV === "development") {
  client = axios.create({
    baseURL: process.env.REACT_APP_API_BASE_URL
  })
} else {
  client = axios.create({baseURL: "http://localhost:3000/api/v1/"})
}

export default client