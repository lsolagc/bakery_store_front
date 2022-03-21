json.extract! rating,
                :id,
                :score,
                :comment,
                :created_at,
                :updated_at
json.user {
  json.extract! rating.user,
                  :id,
                  :name,
                  :surname
}
