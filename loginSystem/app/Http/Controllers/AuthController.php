<?php
namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller {
    // public function register(Request $request) {
    //     $request->validate([
    //         'user_id' => 'required|unique:users',
    //         'user_name' => 'required',
    //         'password' => 'required|min:6',
    //         'user_pin' => 'required|digits:5'
    //     ]);

    //     $user = User::create([
    //         'user_id' => $request->user_id,
    //         'user_name' => $request->user_name,
    //         'password' => Hash::make($request->password),
    //         'user_pin' => Hash::make($request->user_pin)
    //     ]);

    //     return response()->json(['message' => 'User registered successfully'], 201);
    // }

    public function login(Request $request) {
        // Validate input
        $request->validate([
            'user_id' => 'sometimes|required_without:user_name',
            'user_pin' => 'sometimes|required_without:password|digits:5',
            'user_name' => 'sometimes|required_without:user_id',
            'password' => 'sometimes|required_without:user_pin'
        ]);
    
        // Attempt login with user_id and user_pin
        if ($request->filled(['user_id', 'user_pin'])) {
            $user = User::where('user_id', $request->user_id)->first();
            if ($user && Hash::check($request->user_pin, $user->user_pin)) {
                return response()->json(['message' => 'Login successful (PIN)']);
            }
        }
    
        // Attempt login with user_name and password
        if ($request->filled(['user_name', 'password'])) {
            $user = User::where('user_name', $request->user_name)->first();
            if ($user && Hash::check($request->password, $user->password)) {
                return response()->json(['message' => 'Login successful (Username & Password)']);
            }
        }
    
        // If both methods fail, return error
        return response()->json(['error' => 'Invalid credentials'], 401);
    }
}
